// This semantic patch is for matching module init/exit boiler plate code.

@r@
declarer name module_init;
identifier f;
@@
 
module_init(f);
 
@s@
declarer name module_exit;
identifier f;
@@
 
module_exit(f);
 
@a@
identifier r.f;
statement S;
@@
 
f(...) { S }
 
 
@depends on a@
identifier s.f;
statement S;
@@
 
f(...) {
*S
 }

@b@
identifier s.f;
statement S;
@@
 
f(...) { S }
 
@depends on b@
identifier r.f;
statement S;
@@
 
f(...) {
*S
 }
