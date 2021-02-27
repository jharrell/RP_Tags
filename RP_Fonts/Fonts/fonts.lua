local addOnName, ns = ...;

local LibSharedMedia=LibStub("LibSharedMedia-3.0");
local baseFontDir = "Interface\\AddOns\\" .. addOnName .. "\\Fonts\\";

ns.RP_Fonts = ns.RP_Fonts or {};
ns.RP_Fonts.tmp = ns.RP_Fonts.tmp or {};

local family = { 
  SCP = baseFontDir .. "Source_Code_Pro\\SourceCodePro-",
  STM = baseFontDir .. "ShareTechMono\\ShareTechMono-",
  SYN = baseFontDir .. "Syne_Mono\\SyneMono-",
  MSD = baseFontDir .. "Mrs_Saint_Delafield\\MrsSaintDelafield-",
};

local fontList=
{ -- Code   = { Load = true,  Name = "Human Readable Name",                Fam  = "FAM", File = "Regular.ttf"          },
  SCPBla    = { Load = false, Name = "Source Code Pro Black",              Fam  = "SCP", File = "Black.ttf"            },
  SCPBlaIta = { Load = false, Name = "Source Code Pro Black Italic",       Fam  = "SCP", File = "BlackItalic.ttf"      },
  SCPBol    = { Load = true,  Name = "Source Code Pro Bold",               Fam  = "SCP", File = "Bold.ttf"             },
  SCPBolIta = { Load = false, Name = "Source Code Pro Bold Italic",        Fam  = "SCP", File = "BoldItalic.ttf"       },
  SCPExtLig = { Load = false, Name = "Source Code Pro Extra Light",        Fam  = "SCP", File = "ExtraLight.ttf"       },
  SCPExLiIt = { Load = false, Name = "Source Code Pro Extra Light Italic", Fam  = "SCP", File = "ExtraLightItalic.ttf" },
  SCPIta    = { Load = true,  Name = "Source Code Pro Italic",             Fam  = "SCP", File = "Italic.ttf"           },
  SCPLig    = { Load = false, Name = "Source Code Pro Light",              Fam  = "SCP", File = "Light.ttf"            },
  SCPLigIta = { Load = false, Name = "Source Code Pro Light Italic",       Fam  = "SCP", File = "LightItalic.ttf"      },
  SCPMed    = { Load = false, Name = "Source Code Pro Medium",             Fam  = "SCP", File = "Medium.ttf"           },
  SCPMedIta = { Load = false, Name = "Source Code Pro Medium Italic",      Fam  = "SCP", File = "MediumItalic.ttf"     },
  SCPReg    = { Load = true,  Name = "Source Code Pro",                    Fam  = "SCP", File = "Regular.ttf"          },
  SCPSemBol = { Load = false, Name = "Source Code Pro Semi-Bold",          Fam  = "SCP", File = "SemiBold.ttf"         },
  SCPSmBlIt = { Load = false, Name = "Source Code Pro Semi-Bold Italic",   Fam  = "SCP", File = "SemiBoldItalic.ttf"   },
  STMReg    = { Load = true,  Name = "Share Tech Mono",                    Fam  = "STM", File = "Regular.ttf"          },
  SYNReg    = { Load = true,  Name = "Syne Mono",                          Fam  = "SYN", File = "Regular.ttf"          },
  MSDReg    = { Load = true,  Name = "Mrs Saint Delafield",                Fam  = "MSD", File = "Regular.ttf"          },
 };

for fontCode, font in pairs(fontList)
do  LibSharedMedia:Register(LibSharedMedia.MediaType.FONT, font.Name, family[font.Fam] .. font.File); 
    ns.RP_Fonts.tmp[font.Name] = { active = font.Load };
end;

