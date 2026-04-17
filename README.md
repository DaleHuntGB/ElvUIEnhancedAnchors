# ElvUIEnhancedAnchors

This **AddOn** is not affiliated nor developed by ElvUI, it merely acts an improvement on their anchoring system.

## Important Notice
Once **enabled**, anchoring information is written directly to `E.db.movers`, which means this will persist via exports/imports. Unfortunately, this is the only way this can be handled at this point.
<br>
If you want this to be changed, **disabling** or **uninstalling** ElvUIEnhancedAnchors and moving the desired movers via the **ElvUI** will update these values and overwrite any anchoring applied by ElvUIEnhancedAnchors.

## How This Works
- **Set** Mover Position on Events.
- **Hook** into existing ElvUI functions to update movers when necessary.