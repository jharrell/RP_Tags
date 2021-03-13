local addOnName, ns = ...;
local RPTAGS = RPTAGS;
local Module = RPTAGS.queue:GetModule(addOnName);

Module:WaitUntil("before MODULE_J", -- has to run before "frames"
function(self, event, ...)

  local CONST              = RPTAGS.CONST;
  local Utils              = RPTAGS.utils;
  local Config             = Utils.config;
  local frameUtils         = Utils.frames;
  local FRAME_NAMES        = CONST.RPUF.FRAME_NAMES;
  local eval               = Utils.tags.eval;
  local split              = Utils.text.split;
  local notify             = Utils.text.notify;

  local getLeft            = frameUtils.panels.layout.getLeft;
  local getTop             = frameUtils.panels.layout.getTop;
  local getPoint           = frameUtils.panels.layout.getPoint;
  local getHeight          = frameUtils.panels.size.getHeight;
  local getWidth           = frameUtils.panels.size.getWidth;
  local LibSharedMedia     = LibStub("LibSharedMedia-3.0");

  local getUF_Size         = frameUtils.size.get;

  local scaleFrame         = frameUtils.size.scale.set;
  local toRGB              = Utils.color.hexaToNumber;

  local function initialize_panel(self, opt)

    --   -- passthrough ---------------------------------------------------------------------------------------
   
    function self.Public(self, funcName, ... ) return self:GetParent():Public(funcName,        ... ) end;
    function self.Gap(       self,     ... ) return self:GetParent():Public("Gap",           ... ) end;
    function self.GetUnit(   self,     ... ) return self:GetParent():Public("GetUnit",       ... ) end;
    function self.GetLayoutName( self, ... ) return self:GetParent():Public("GetLayoutName", ... ) end;
    function self.ConfGet(   self,     ... ) return self:GetParent():Public("ConfGet",       ... ) end;
    function self.ConfSet(   self,     ... ) return self:GetParent():Public("ConfSet",       ... ) end;
    function self.PanelGet(  self,     ... ) return self:GetParent():Public("PanelGet",      ... ) end;

    --   -- general -------------------------------------------------------------------------------------------
    
    function self.Place(self)
      -- local layout = self:GetLayoutName();
      if self.GetPanelLeft and self.GetPanelTop and self.GetPanelHeight and self.GetPanelWidth
      then 
        local left   = self:GetPanelLeft();   -- getLeft(   self.name, layout);
        local top    = self:GetPanelTop();    -- getTop(    self.name, layout);
        local height = self:GetPanelHeight(); -- getHeight( self.name, layout);
        local width  = self:GetPanelWidth();  -- getWidth(  self.name, layout);

        self:ClearAllPoints();
        self:SetPoint("TOPLEFT", self:GetParent(), "TOPLEFT", left, top * -1);
        self:SetSize(width, height);
      else
        self:Hide();
      end;
    end;

    function self.SetVis(self) self:SetShown( self.GetPanelVis and self:GetPanelVis() ) end;

    opt = opt or {};

    --   ---- has_statusBar -----------------------------------------------------------------------------------
    if   opt["has_statusBar"]
    then 

      self.statusBar = self:CreateTexture();
      self.statusBar:SetColorTexture(1, 1, 1, 0.5);
      self.statusBar:SetAllPoints();

      function self.SetStatusbar(   self, textureFile ) self.statusBar:SetTexture(textureFile) end;
      function self.SetVertexColor( self, ...         ) self.statusBar:SetVertexColor(...)     end;

    end;

    --   -- not no_tag_string ---------------------------------------------------------------------------------
    if not opt["no_tag_string"]
    then 

      self.text = self:CreateFontString(self:GetParent():GetName() .. 
                  self.name .. "Tag", "OVERLAY", "GameFontNormal");

      self.text:SetAllPoints();
      self.text:SetText(self.name);

      function self.SetTagString( self) self:GetParent():Tag(self.text, Config.get(self.setting)) end;
      function self.SetTextColor( self, r, g, b) self.text:SetTextColor(r, g, b)                end;

      function self.GetJustify(self)
        if     self.name == "statusBar" 
        then   return self:ConfGet("STATUS_ALIGN"), "CENTER";
        elseif (self.name == "name" or self.name == "info") 
                 and
               (self:GetLayoutName() == "PAPERDOLL" or self:GetLayout() == "THUMBNAIL")
        then   return "CENTER", "CENTER";
        else   return "LEFT", "TOP";
        end;
      end;

      function self.SetJustify(self)
        self.text:SetJustifyH( self:GetPanelJustifyH() );
        self.text:SetJustifyV( self:GetPanelJustifyV() );
      end;
  
      local font_size_hash =
      { ["extrasmall" ] = -4, ["small" ] = -2, ["medium" ] = 0, ["large" ] = 2, ["extralarge" ] = 4 };
  
      function self.GetFont(self, ...) return self:GetParent():Public("GetFont", ...) end;

      function self.AdjustFont(self, size)
        return size + (font_size_hash[ Config.get( self.setting .. "_FONTSIZE" )] or 0);
      end;

      function self.GetFontSize(self, ...)
        local _, fontSize = self:GetFont(...);
        return fontSize or 10;
      end;

      function self.GetActualFontSize(self) return self:AdjustFont( self:GetFontSize() ); end;

      if opt["use_font"]
      then 

        function self.SetFont(self, fontFile, fontSize)

          if not fontSize then _, fontSize = self:GetFont(); end;
          local  fontName = self:ConfGet( opt["use_font"] )
          self.text:SetFont( LibSharedMedia:Fetch("font", fontName  ) or
                             LibSharedMedia:Fetch("font", "Morpheus"),
                             self:AdjustFont(fontSize));

        end;

      else

        function self.SetFont(self, fontFile, fontSize)

          if not fontFile then fontFile, _ = self:GetFont(); end;
          if not fontSize then _, fontSize = self:GetFont(); end;
          self.text:SetFont(fontFile, self:AdjustFont(fontSize));

        end;

      end;
            
    end;

    --   ---- portrait ----------------------------------------------------------------------------------------
    if   opt["portrait"]
    then 
      local portrait3D = CreateFrame("PlayerModel", nil, self, "ModelWithControlsTemplate");
      local portrait2D = self:CreateTexture(nil, "OVERLAY");

      portrait3D:SetPoint("TOPRIGHT", self, "TOPRIGHT", -5, -5);
      portrait3D:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 5, 5);
      portrait3D:Show();

      portrait2D:SetPoint("LEFT", 5, 0);
      portrait2D:SetPoint("RIGHT", -5, 0);
      portrait2D:SetHeight( portrait2D:GetWidth() );

      portrait2D:Show();

      self.pictureFrame = CreateFrame("Frame", nil, self, BackdropTemplateMixin and "BackdropTemplate");
      self.pictureFrame:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 5, 5);
      self.pictureFrame:SetPoint("TOPRIGHT",   self, "TOPRIGHT", -5, -5);

      self.pictureFrame:SetBackdrop(
      { bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background", 
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border" 
      });

      self.portrait3D = portrait3D;
      self.portrait2D = portrait2D;

      self:GetParent().Portrait = portrait3D;
      self:GetParent().Portrait3D = portrait3D;
      self:GetParent().Portrait2D = portrait2D;

    end;
 
    --   -- tooltips ------------------------------------------------------------------------------------------
    if not opt["no_tooltip"]
    then 

      self:EnableMouse();
      self:SetScript("OnEnter", showTooltip );
      self:SetScript("OnLeave", hideTooltip );
      self.tooltip = tooltip;
      
      function self.GetTooltipColor(self, ...) return self:GetParent():Public("GetTooltipColor", ...) end;

      function self.showTooltip(self, event, ...) 
        local tooltip = eval(Config.get(self.tooltip), self:GetUnit(), self:GetUnit());
        local r, g, b = self:GetTooltipColor();
    
        if   self:ConfGet("MOUSEOVER_CURSOR")
        then SetCursor("Interface\\CURSOR\\Inspect.PNG");
        end;
    
        if tooltip and tooltip:len() > 0 -- only show a tooltip if there's something to show
        then GameTooltip:ClearLines();
             GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
             GameTooltip:SetOwner(self, "ANCHOR_PRESERVE");
  
             local lines = split(tooltip, "\n"); -- this is our sneaky way of getting a "title"
             for i, line in ipairs(lines) do GameTooltip:AddLine(line, r, g, b, true) end;
  
             GameTooltip:Show();
        end;
      end; 
  
      function hideTooltip(self, ...) 
        GameTooltip:FadeOut(); 
        ResetCursor(); 
        return self, ... 
      end;
  
    end;
  
    --   -- context_menu --------------------------------------------------------------------------------------
    if not opt["no_context_menu"]
    then 

      -- obvious placeholder is obvious
      function showContextMenu(self, event, ...) notify("context menu for", self.name); end;
  
      self:SetScript("OnMouseUp",
        function(self, button, ...) 
          if   button == "RightButton" then showContextMenu(self, button, ...) end; 
        end);

    end;
  
    --   -- layouts -------------------------------------------------------------------------------------------
    function self.SetLayout(self, layoutName)
      layoutName = layoutName or self:GetLayoutName();

      local  layoutStruct = RPTAGS.utils.frames.RPUF_GetLayout(layoutName);
      if not layoutStruct then return end;

      for key, func in pairs(layoutStruct.panel_methods) do self[key] = func; end; 

      for hashName, hashTable in pairs(layoutStruct.panel_method_hash)
      do  
          local  item = hashTable[self.name];

          if     type(item) == "boolean" or type(item) == "number" 
          then   self[hashName] = function(self) return item end;

          elseif type(item) == "string" and type(hashTable[item]) == "function" 
          then   self[hashName] = hashTable[item];

          elseif type(item) == "string" and (type(hashTable[item]) == "boolean" or type(hashTable[item]) == "number")
          then   self[hashName] = function(self) return hashTable[item] end;

          elseif type(item) == "function" 
          then   self[hashName] = item;

          else   self[hashName] = nil;
          end;
      end;
    end;
 
    --
    --   ------------------------------------------------------------------------------------------------------
  
  end;

  RPTAGS.utils.frames.initialize_panel = initialize_panel;
  
end);
  
