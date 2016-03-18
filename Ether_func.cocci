// This semantic patch is for ether device API functions.
@eth_zero_addr@
expression e;
@@

-memset(e,0x00,\(6\|ETH_ALEN\));
+eth_zero_addr(e);

@eth_broadcast_addr@
identifier e;
@@

-memset(e,\(0xff\|0xFF\|255\),\(6\|ETH_ALEN\));
+eth_broadcast_addr(e);
