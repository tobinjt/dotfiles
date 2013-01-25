if !exists(':Tabularize')
  finish " Tabular.vim wasn't loaded
endif

" Align on the first comma, first single quota, first double quote.
AddTabularPattern! fc  /^[^,]\+,\zs/l0r1
AddTabularPattern! fsq /^[^']\+\zs'/l0r0
AddTabularPattern! fdq /^[^"]\+\zs"/l0r0
AddTabularPattern! colon /:\zs/l0r1
AddTabularPattern! space / /l0r0
