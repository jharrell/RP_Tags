# rpTags

rpTags lets you create customized unit frames based on fields from roleplaying 
profiles, such as those used by [totalRP3](https://www.curseforge.com/wow/addons/total-rp-3) or
[MyRolePlay](https://www.curseforge.com/wow/addons/my-role-play). This lets you choose 
which details are most important to you.

### What's a Unit Frame? What's a tag?

Unit frames are the boxes on your screen that show information about specific units -- 
for example, yourself ("Player" frame), your target ("Target"), your 
focus ("Focus"), or your target's target("TargetTarget").

These are created by addons such as [ElvUI](https://www.tukui.org/download.php?ui=elvui)

A tag is simply a word encased in square brackets that you use to customize unit frames.
The tags in rpTags all start with `rp:` (with a few exceptions) and so, rp:tags.

Examples include:

| rp:tag            | Displays                                                               |
| :---------------- | :----------------------------------------                              |
|  `[rp:name]`      | The unit's roleplaying name                                            |
|  `[rp:race]`      | The unit's RP race, which might not be the same as their in-game race  |
|  `[rp:icon]`      | The unit's icon                                                        |
|  `[rp:age]`       | The unit's age. if listed                                              |
| `[rp:color]`      | Changes the following text to the unit's chosen color                  |

## Installation

The easiest way to install rpTags is by using 
[an addon manager](https://www.wowhead.com/guides/best-addon-managers-wow-shadowlands).
If you use [Ajour](https://www.getajour.com/), [CurseBreaker](https://github.com/AcidWeb/CurseBreaker),
[InstaWow](https://github.com/layday/instawow), or [WowUp](https://wowup.io/), you can install
directly from the [releases site on GitHub](https://github.com/caderaspindrift/RP_Tags/releases).

rpTags is also available on [CurseForge](https://www.curseforge.com/wow/addons/rp-tags).

If you want to install rpTags manually, go to your WoW directory, then `_retail_`,
`Interface`, `AddOns`, and unzip the zip file there.

It will produce not one, not two, but *six* different addons?!

    RP_Tags/
    RP_Tags_ElvUI/
    RP_Tags_Listener/
    RP_Tags_MyRolePlay/
    RP_Tags_totalRP3/
    RP_UnitFrames/

To understand why, we need to talk about ...

## AddOn Structure

This version of rpTags is built on a modular base. Everything
that is specific to a certain module has been isolated there.
This allows us to use WoW's normal AddOn management system to
best adavantage.

For example, everything related to 
integrating [MyRolePlay](https://www.curseforge.com/wow/addons/my-role-play)
into the rpTags framework can be found in `RP\_Tags\_MyRolePlay`.

The module won't load if you aren't running MyRolePlay.
Okay, it *might*, but we can't be responsible for any error messages
you might see! That said, we do have code to minimize actual errors
of that kind, instead popping up rpTags alerts.

### rpClients and unitFrames

There are three kinds of modules for rpTags:

 - A **Roleplaying AddOn** module that lets rpTags access information
   about characters from a RP AddOn such as 
   [MyRolePlay](https://www.curseforge.com/wow/addons/my-role-play),
   which provides the information about
   characters by sending, receiving, and storing RP profiles; and

 - A **Unit Frames AddOn** module to display that information in a
   customizable format, such as the unit frames provided by
   [ElvUI](https://www.tukui.org/download.php?ui=elvui)

 - A **Data Source AddOn** module that allows rpTags to use tags based
   on another AddOn, such as
   [Listener](https://www.curseforge.com/wow/addons/listener)

This means that you're going to have five (or more) addons active:

 1  Your roleplaying addon;
 2  A rpClient module that serves as a bridge between 
    rpTags and the roleplaying addon;
 3  rpTags itself, which provides the core functions;
 4  A unitFrames module that is the bridge to a unit frames
    Addon; and
 5  Your unitFrames addon itself.

The second, third, and fourth are all included with rpTags.
In fact, we've even thrown in a simple unit frames addon as 
well, called rpUnitFrames, which can run alongside or parallel to
ElvUI's or Blizzard's frames.

### Supported AddOns

The current version of rpTags supports integration with these addons:

| AddOn Name             |   rpClient     |     unitFrames   | dataSource |
| :-------------         |  :--------:    |    :----------:  | :--------: |
| Blizzard's unit frames |     --         |        No        |  --        |
| ElvUI                  |     --         |        Yes       |  --        |
| Listener               |     --         |        --        |  Yes       |
| MyRolePlay             |     Yes        |        --        |  --        |
| rpUnitFrames           |     --         |        Yes       |  --        |
| Total RP 3             |     Yes        |        --        |  --        |
| XRP                    |     No         |        --        |  --        |

## Using rpTags

Assuming that you've got both a supported RP addon and a supported
unit frames addon, you can just start using the new tags wherever
they're found in your unit frames addon.

In ElvUI, you type `/ec` to open the options page, go to the 
Unit Frames section, and then choose a frame, such as your target
or the members of your party. Pick a field as Power -- or create a
custom field -- and then enter one or more rp:tags into the box.

In rpUnitFrames it's similar; you can specify not only what you
see when you are viewing the frame, but also the tooltip shown
when you mouse-over those sections of the frame. For example, you
could use this in the "Name" panel:

    [rp:name]

And this in the "Name Tooltip" panel:

    [rp:shorttitle] [rp:firstname] [rp:lastname] [br] [rp:title]

## rp:tags

A tag, in this sense, consists of an opening square
bracket -- `[` -- then the letters `rp`, then a colon -- `:` --
and the name of the tag in lowercase, all ending with a
closing square bracket, `]`.

You saw one example above. Here's another:

    [rp:glance-3-icon] [rp:glance-3] [rp:glance-3-text]

This serieso tags would display the subject's third "At First
Glance" icon, the title of it, and the associated description.

If any of those *aren't* set, nothing will be shown for that
setting.

## List of rp:tags

The full list of rp:tags is long -- over 300 at last count --
and you can use modifier tags (see below) on many as well. 

You can browse them on WoW with the `/rptags` command, or review
the [list on our Wiki](https://github.com/caderaspindrift/RP_Tags/wiki/Tag-List).

### Modifier Tags

There are two types of modifier tags -- labels and sizes. 
A label modifier is applied after the main tag, with a dash (-)
after it, like this:

    [rp:title:label] 

> Title: Stormwind Fashion Icon

A size modifier is also applied after a tag, in parentheses.

| Size Modifier    | Default Size   |
| :--------------: | -------------: |
| `(xs)`           | 5 characters   |
| `(s)`            | 10 characters  |
| `(m)`            | 15 characters  |
| `(l)`            | 20 characters  |
| `(xl)`           | 50 characters  |
| `(8)`\*          | 8 characters   |
| `(42)`\*         | 42 characters  |
| --               | no limit       |

Numeric size modifiers are not supported in ElvUI.

## /Slash Commands

The following commands can be typed into the normal WoW chat box:

| Command             | Displays                                                  |
| :------------------ | :-------------------------------------------------        |
| `/rptags`           | Help, tag reference, options                              |
| `/rptags options`   | Options                                                   |
| `/rptags colors`    | Color options                                             |
| `/rptags changes`   | Recent changes                                            |
| `/rptags version`   | Current version information for rpTags and related addons |
| `/rptags rpuf`      | rpUnitFrames options                                      |

## Configuration

Configuration is fairly simple; you can set your own colors for many of
the `color` tags, the formats for fields like height and weight (feet and
inches, or meters and centimeters?) and so on.

You *don't* have to tell rpTags which rpClient or unitFrames modules to use;
it can figure out which ones to use based on which of the supported addons
you're already using.

## Localization

The addon is currently only available in English, but if you want help with
translations into other languages, you can get in touch with us.

## To Do

- [x] Change versions to 9.0.2
  - [x] Change versions to 9.0.5
- [x] Make sure all the libraries are current
  - [x] WoW 9.0.5
- [x] Get configuration/help working
- [x] Keybinds
- [x] ~~More work on AMDC~~ - moved to [new repository](https://github.com/caderaspindrift/WoW-LibMarkdown)
- [x] Localization strings for options
- [x] Review help files
  - [x] Help file for labels and sizes
- [ ] Modules
  - [ ] MyRoleplay
    - [x] Keybinds working
    - [x] Index addon functions
    - [ ] P2: Confirm which tags should be `unsup` for MRP
    - [ ] P1: Update for new pronoun settings in trp3/MRP
  - [ ] TRP3
    - [x] Index addon functions
    - [x] Keybinds working
    - [ ] P1: Update for new pronoun settings in trp3/MRP
  - [ ] ElvUI
    - [x] ~~Get labels working in ElvUI~~
    - [x] Get size modifiers working in ElvUI (work-around for old oUF) 
    - [ ] Get color modifiers working in ElvUI (work-around for old oUF)
    - [x] Index addon functions
    - [x] Don't "add" oUF/ElvUI tags to listing
  - [ ] Listener
    - [x] Add tags
    - [ ] P3: Index addon functions
- [ ] rpUnitFrames 
  - [x] Index addon functions
  - [x] Fonts moved to [rpFonts](https://www.curseforge.com/wow/addons/rpfonts)
  - [ ] P2: Keybinds working
  - [ ] P3: Localization strings for options
  - [ ] P3: Review and update help files
  - [ ] Frames
    - [x] P1: Individualized settings per frame
    - [x] Options for per-frame settings
    - [x] P1: LibSharedMedia for frames
    - [x] P1: Frames movable/position
    - [x] P1: Frame color
    - [x] P1: Unit frames fully working
    - [x] P2: Review default frame settings
    - [x] P2: Default layouts
    - [x] P1: Fix paperdoll layout
    - [x] P1: Fix thumbnail layout
    - [x] P2: Tweak abridged layout
    - [x] P2: Tweak compact layout
    - [x] P2: Tweak full layout
    - [x] P3: Blizzlike layout
    - [x] P2: Unit colors
    - [ ] P3: Allow "custom" unit colors, to use color tag modifiers
    - [ ] P2: Context menu
  - [x] Tags
    - [x] Get labels working in rpUnitFrames
    - [x] P1: Confirm size modifiers working in rpUnitFrames
    - [x] P2: Color modifiers
  - [ ] Panels
    - [x] P1: Mouseovers
    - [x] P1: Fix portrait
    - [x] P2: Review default panel settings
    - [ ] P2: Context menu
  - [ ] Editor
    - [x] Tag live previews
    - [x] RP:UF editor layout
    - [x] Tag editor buttons
    - [x] Color picker for editor
    - [x] Editor status bar (lower) buttons
    - [x] P2: LibSharedMedia for editor
    - [x] P1: "More" button
    - [x] P2: Right-/modifier-clicks on toolbar
    - [x] P3: Localization strings for editor
    - [ ] P2: Layout tweaking
- [ ] Long-Term
  - [ ] Config profiles with Ace3?
  - [ ] XRP support
  - [ ] Generalize rpTags for any oUF addon
  - [ ] Generalize rpTags for any MSP addon
