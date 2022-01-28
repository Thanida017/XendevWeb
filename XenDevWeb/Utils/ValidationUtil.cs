using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;

namespace XenDevWeb.Utils
{
    public class ValidationUtil
    {
        public static bool isEmpty(string s, bool noAcceptSpecialCharacters = true)
        {
            if (s == null)
            {
                return true;
            }

            if (noAcceptSpecialCharacters)
            {
                char[] specialCharacters = new char[] { '\\', '/', ':', '*', '<', '>', '|', '#', '{', '}', '%', '~', '&', ';', '^', '@', '$' };
                if (s.IndexOfAny(specialCharacters) >= 0)
                {
                    return false;
                }
            }

            return s.Trim().Length == 0;
        }

        public static bool isDigit(string s)
        {
            bool hasError = false;
            try
            {
                decimal d = decimal.Parse(s, CultureInfo.CreateSpecificCulture("en-US"));
            }
            catch
            {
                hasError = true;
            }

            return !hasError;
        }
    }
}