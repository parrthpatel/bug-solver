//This semantic patch is for setup_timer function. This patch is now added in the Linux kernel. 
//http://lxr.free-electrons.com/source/Documentation/coccinelle.txt
//https://home.regit.org/technical-articles/coccinelle-for-the-newbie/

@match_immediate_function_data_after_init_timer@
expression e, func, da;
@@

-init_timer (&e);
+setup_timer (&e, func, da);

(
-e.function = func;
-e.data = da;
|
-e.data = da;
-e.function = func;
)

@match_function_and_data_after_init_timer@
expression e1, e2, e3, e4, e5, a, b;
@@

-init_timer (&e1);
+setup_timer (&e1, a, b);

... when != a = e2
    when != b = e3
(
-e1.function = a;
... when != b = e4
-e1.data = b;
|
-e1.data = b;
... when != a = e5
-e1.function = a;
)

@r1 exists@
identifier f;
position p;
@@

f(...) { ... when any
  init_timer@p(...)
  ... when any
}

@r2 exists@
identifier g != r1.f;
struct timer_list t;
expression e8;
@@

g(...) { ... when any
  t.data = e8
  ... when any
}

@script:python depends on r2@
p << r1.p;
@@

print "Data field initialized in another function. Dangerous to use setup_timer %s:%s" % (p[0].file,p[0].line)
cocci.include_match(False)

@r3@
expression e6, e7, c;
position r1.p;
@@

-init_timer@p (&e6);
+setup_timer (&e6, c, 0UL);
... when != c = e7 
-e6.function = c;

