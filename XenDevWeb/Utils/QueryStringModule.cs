using System;
using System.IO;
using System.Web;
using System.Text;
using System.Security.Cryptography;

namespace XenDevWeb.Utils
{
    public class QueryStringModule : IHttpModule
    {
        public void Dispose()
        {

        }

        public void Init(HttpApplication context)
        {
            context.BeginRequest += new EventHandler(context_BeginRequest);
        }

        private const string PARAMETER_NAME = "enc=";
        private const string ENCRYPTION_KEY = "MAKV2SPBNI99212";

        void context_BeginRequest(object sender, EventArgs e)
        {
            HttpContext context = HttpContext.Current;
            if (context.Request.Url.OriginalString.Contains("aspx") && context.Request.RawUrl.Contains("?"))
            {
                string query = ExtractQuery(context.Request.RawUrl);
                string path = GetVirtualPath();

                if (query.StartsWith(PARAMETER_NAME, StringComparison.OrdinalIgnoreCase))
                {
                    // Decrypts the query string and rewrites the path.
                    string rawQuery = query.Replace(PARAMETER_NAME, string.Empty);
                    string decryptedQuery = Decrypt(rawQuery);
                    context.RewritePath(path, string.Empty, decryptedQuery);
                }
                else if (context.Request.HttpMethod == "GET")
                {
                    // Encrypt the query string and redirects to the encrypted URL.
                    // Remove if you don't want all query strings to be encrypted automatically.
                    string encryptedQuery = Encrypt(query);
                    context.Response.Redirect(path + encryptedQuery);
                }
            }
        }

        private static string GetVirtualPath()
        {
            string path = HttpContext.Current.Request.RawUrl;
            path = path.Substring(0, path.IndexOf("?"));
            path = path.Substring(path.LastIndexOf("/") + 1);
            return path;
        }

        private static string ExtractQuery(string url)
        {
            int index = url.IndexOf("?") + 1;
            return url.Substring(index);
        }


        private readonly static byte[] SALT = Encoding.ASCII.GetBytes(ENCRYPTION_KEY.Length.ToString());

        public static string Encrypt(string inputText)
        {
            byte[] clearBytes = Encoding.Unicode.GetBytes(inputText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(ENCRYPTION_KEY, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    inputText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return inputText;
        }

        public static string Decrypt(string inputText)
        {
            inputText = inputText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(inputText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(ENCRYPTION_KEY, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    inputText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return inputText;
        }

    }
}