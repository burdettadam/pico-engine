ruleset io.picolabs.scope {
  meta {
    name "testing scope"
    shares g0, g1, getVals, add
  }
  global {
    g0 = "global 0" 
    g1 = 1
    getVals = function(){
      {
        "name": ent:ent_var_name,
        "p0": ent:ent_var_p0,
        "p1": ent:ent_var_p1
      }
    }
    add = function(a, b){
      a + b
    }
    incByN = function(n){
      function(a){
        a + n
      }
    }
  }
  rule eventex {
    select when
      scope event0 name re#^(.*)$# setting(my_name)
      or
      scope event1;
    send_directive("say") with
      name = my_name
  }
  rule prelude_scope {
    select when scope prelude name re#^(.*)$# setting(name);

    pre {
      p0 = "prelude 0"
      p1 = "prelude 1"
    }

    send_directive("say") with
      name = name
      p0 = p0
      p1 = p1
      g0 = g0

    always {
      ent:ent_var_name := name;
      ent:ent_var_p0 := p0;
      ent:ent_var_p1 := p1
    }
  }
  rule functions {
    select when scope functions;

    pre {
      g0 = "overrided g0!"
      inc5 = incByN(5)
    }

    send_directive("say") with
      add_one_two = add(1, 2)
      inc5_3 = inc5(3)
      g0 = g0
  }
}
