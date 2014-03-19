﻿###zplosteni.prolog###
Definujte predikát `zplosteni/2`, který vrátí seznam "listů" zadaného vstupního seznamu.

```
% zplosteni(+Seznam,-ListySeznamu) 
% ?- zplosteni([a,[b,c],[[d]],[],[[[e]]],f], L). 
% L=[a,b,c,d,e,f].
```

Pokuste se o koncově rekurzivní řešení využívající akumulátor.