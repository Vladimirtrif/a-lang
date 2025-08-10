### A-lang Context Free Grammar (CFG)

Program := (Function)* MainFunction (Function)* <EOF>  
  
MainFunction := "function" "main" "(" ")" "{" (Statement)+ "}"  
  
Function := "function" Identifier "(" (Identifier ":" Type ("," Identifier ":" Type)*)? ")" "{" (Statement)\* "return" Expression ";" "}"  

Type := "int"  
     | "bool"  

Statement := "if" "(" Expression ")" "{" (Statement)+ "}" "else" (Statement)+    
          | "while" "(" Expression ")" "{" Statement+ "}"  
          | Identifier "=" Expression ";"  
          | "Print" "(" Expression ")" ";"  

Expression := Expression ("&&" | "||" | ">" | "==" | "+" | "-" | "*") Expression  
           | "true"  
           | "false"  
           | IntegerLiteral  
           | Identifier  
           | "(" Expression ")"  
           | "!" Expression  
           | "(" Expression ")" ? "then" Expression "otherwise" 

### A-lang regular expressions (regex)

IntegerLiteral = [0-9]+  

Identifier = [A-Za-z]+([A-Za-z] | [0-9] | "_" | "$")*