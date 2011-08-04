function DrawMenu {
  param($menuItems, $menuPosition, $menuTitle)
  $fcolor = $host.ui.rawui.ForegroundColor
  $bcolor = $host.UI.RawUI.BackgroundColor
  $l = $menuItems.length + 1
  cls
  $menuwidth = $menuTitle.length + 4
  Write-Host "`t" -NoNewLine
  Write-Host ("*" * $menuwidth) -fore $fcolor -back $bcolor
  Write-Host "`t" -NoNewLine
  Write-Host "* $menuTitle *" -fore $fcolor -back $bcolor
  Write-Host "`t" -NoNewLine
  Write-Host ("*" * $menuwidth) -fore $fcolor -back $bcolor
  Write-Host ""
  Write-debug "L: $l MenuItems: $menuItems MenuPosition: $menuposition"
  for ($i = 0; $i -le $l;$i++) {
    Write-Host "`t" -NoNewLine
    if ($i -eq $menuPosition) {
      Write-Host "$($menuItems[$i])" -fore $bcolor -back $fcolor
    } else {
      Write-Host "$($menuItems[$i])" -fore $fcolor -back $bcolor
    }
  }
}


function Menu {
  param([array]$menuItems, $menuTitle = "MENU")

  $vkeycode = 0
  $pos = 0

  DrawMenu $menuItems $pos $menuTitle

  While ($vkeycode -ne 13) {
    $press = $host.ui.rawui.readkey("NoEcho,IncludeKeyDown")
    $vkeycode = $press.virtualkeycode
    Write-Host "$($press.character)" -NoNewLine
    If ($vkeycode -eq 38) {$pos--}
    If ($vkeycode -eq 40) {$pos++}
    If ($pos -lt 0) {$pos = $menuItems.length -1}
    If ($pos -ge $menuItems.length) {$pos = 0}
    DrawMenu $menuItems $pos $menuTitle
  }
  Write-Output $($menuItems[$pos])
}