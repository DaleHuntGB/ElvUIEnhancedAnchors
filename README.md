# ElvUIEnhancedAnchors

A lightweight extension for **ElvUI** that improves how mover anchoring behaves.

This AddOn is not affiliated with or developed by ElvUI.

## Important Notice

When enabled, anchoring data is written directly to `E.db.movers`. This means all changes will persist through profile exports and imports.

To revert:

* Disable or uninstall **ElvUIEnhancedAnchors**.
* Reposition movers using **ElvUI**.

**ElvUI** will overwrite any anchors applied by this AddOn.

## How It Works

* Applies mover positions automatically based on events.
* Hooks into **ElvUI** `ToggleMovers` function to update movers when required.