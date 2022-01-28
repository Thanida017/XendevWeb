var EndTypA = draw2d.shape.node.End.extend({

    NAME : "EndTypA",
    
    init : function(attr)
    {
        this._super($.extend({
          width:30,
          height:30,
          bgColor:"#ff0000"
        },attr));

        this.getPorts().each( (i,port) => port.setSemanticGroup("red"))
    }
});
