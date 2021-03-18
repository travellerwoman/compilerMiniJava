%skeleton "lalr1.cc" 
%defines
%define parse.error verbose
%define api.value.type variant
%define api.token.constructor

%code requires{
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string>
    #include "Node.h"
}

%code{
    #define YY_DECL yy::parser::symbol_type yylex()

    YY_DECL;
    
    Node* root;

    extern int node_id;
}

%left <string> tk_letra
%left <string> tk_cifra
%left <string> tk_space
%left <string> tk_new_line
%left <string> tk_identifier
%left <string> tk_comment
%left <string> tk_comment2
%left <string> tk_string
%left <string> tk_open_parenthesis
%left <string> tk_close_parenthesis
%left <string> tk_open_bracket
%left <string> tk_close_bracket
%left <string> tk_open_sbracket
%left <string> tk_close_sbracket
%left <string> tk_and
%left <string> tk_plus
%left <string> tk_minus
%left <string> tk_barra
%left <string> tk_multiply
%left <string> tk_this
%left <string> tk_new
%left <string> tk_exclamation
%left <string> tk_relop
%left <string> tk_equals
%left <string> tk_length
%left <string> tk_dot
%left <string> tk_dotcoma
%left <string> tk_coma

/*Reserved words*/

%token END 0 "end of file"
%token <string> tk_true
%token <string> tk_false
%token <string> tk_class
%token <string> tk_public
%token <string> tk_static
%token <string> tk_void
%token <string> tk_main
%token <string> tk_var_String
%token <string> tk_extends
%token <string> tk_type_int
%token <string> tk_type_boolean
%token <string> tk_if
%token <string> tk_else
%token <string> tk_while
%token <string> tk_sop
%token <string> tk_return

%type <Node *> Goal MainClass ClassDeclaration VarDeclaration MethodDeclaration Type Statement Expression Identifier ClassDeclarationList extId VarDeclarationList MethodDeclarationList StatementList ComaTypeId TypeIdComaTypeId ComaExp ExpComaExp

%% /* Grammar rules and actions follow. */

Goal: MainClass ClassDeclarationList END
    {
        printf("[B] Goal ");
        $$ = new Node("Goal", "");
        $$->children.push_back($1);
        $$->children.push_back($2);
        root = $$;
    }
    | MainClass
    {
        printf("[B] Goal ");
        $$ = new Node("Goal", "");
        $$->children.push_back($1);
        root = $$;
    }
    ;

MainClass: tk_class Identifier tk_open_bracket tk_public tk_static tk_void tk_main tk_open_parenthesis tk_var_String tk_open_sbracket tk_close_sbracket Identifier tk_close_parenthesis tk_open_bracket Statement tk_close_bracket tk_close_bracket
    {
        printf ("[B] Mainclass ");
        $$ = new Node("MainClass", "");
        $$->children.push_back($2);
        $$->children.push_back($12);
        $$->children.push_back($15);
    }
    ;

ClassDeclarationList: ClassDeclaration
        {

            $$ = $1;
        }
    | ClassDeclarationList ClassDeclaration
        {
            $$ = new Node("ClassDeclarationList", "");
            $$->children.push_back($1);
            $$->children.push_back($2);
        }
    ;

extId: tk_extends Identifier
        {
            $$ = $2;
        }
    ; 
    
ClassDeclaration: tk_class Identifier extId tk_open_bracket VarDeclarationList MethodDeclarationList tk_close_bracket 
    {
        printf("[B] ClassDeclaration ");
        $$ = new Node("ClassDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($3);
        $$->children.push_back($5);
        $$->children.push_back($6);
    }
    | tk_class Identifier tk_open_bracket VarDeclarationList MethodDeclarationList tk_close_bracket
    {
        printf("[B] ClassDeclaration ");
        $$ = new Node("ClassDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($4);
        $$->children.push_back($5);
    }
    | tk_class Identifier extId tk_open_bracket MethodDeclarationList tk_close_bracket 
    {
        printf("[B] ClassDeclaration ");
        $$ = new Node("ClassDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($3);
        $$->children.push_back($5);
    }
    | tk_class Identifier tk_open_bracket MethodDeclarationList tk_close_bracket
    {
        printf("[B] ClassDeclaration ");
        $$ = new Node("ClassDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($4);
    }
    | tk_class Identifier extId tk_open_bracket VarDeclarationList tk_close_bracket 
    {
        printf("[B] ClassDeclaration ");
        $$ = new Node("ClassDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($3);
        $$->children.push_back($5);
    }
    | tk_class Identifier tk_open_bracket VarDeclarationList tk_close_bracket
    {
        printf("[B] ClassDeclaration ");
        $$ = new Node("ClassDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($4);
    }
    | tk_class Identifier extId tk_open_bracket tk_close_bracket 
    {
        printf("[B] ClassDeclaration ");
        $$ = new Node("ClassDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($3);
    }
    | tk_class Identifier tk_open_bracket tk_close_bracket
    {
        printf("[B] ClassDeclaration ");
        $$ = new Node("ClassDeclaration", "");
        $$->children.push_back($2);
    }
    ;

VarDeclarationList: VarDeclaration
        {
            $$ = $1;
        }
    | VarDeclarationList VarDeclaration
        {
            $$ = new Node("VarDeclarationList", "");
            $$->children.push_back($1);
            $$->children.push_back($2);
        }
    ;
    
VarDeclaration: Type Identifier tk_dotcoma
    {
        printf("[B] VarDeclaration ");
        $$ = new Node("VarDeclaration", "");
        $$->children.push_back($1);
        $$->children.push_back($2);
    }
    ;

MethodDeclarationList: MethodDeclaration
        {
            $$ = $1;
        }
    | MethodDeclarationList MethodDeclaration
        {
            $$ = new Node("MethodDeclarationList", "");
            $$->children.push_back($1);
            $$->children.push_back($2);
        }
    ;


ComaTypeId: tk_coma Type Identifier
        {
            $$ = new Node("ComaTypeId", "");
            $$->children.push_back($2);
            $$->children.push_back($3);
        }
    | ComaTypeId tk_coma Type Identifier
        {
            $$ = new Node("ComaTypeId", "");
            $$->children.push_back($1);
            $$->children.push_back($3);
            $$->children.push_back($4);
        }
    ;

TypeIdComaTypeId: Type Identifier ComaTypeId
        {
            $$ = new Node("TypeIdComaTypeId", "");
            $$->children.push_back($1);
            $$->children.push_back($2);
            $$->children.push_back($3);
        }
    | Type Identifier
        {
            $$ = new Node("TypeId", "");
            $$->children.push_back($1);
            $$->children.push_back($2);
        }
    ;

MethodDeclaration: tk_public Type Identifier tk_open_parenthesis TypeIdComaTypeId tk_close_parenthesis tk_open_bracket VarDeclarationList StatementList tk_return Expression tk_dotcoma tk_close_bracket
    {
        printf("[B] MethodDeclaration ");
        $$ = new Node("MethodDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($3);
        $$->children.push_back($5);
        $$->children.push_back($8);
        $$->children.push_back($9);
        $$->children.push_back($11);
    }
    | tk_public Type Identifier tk_open_parenthesis TypeIdComaTypeId tk_close_parenthesis tk_open_bracket StatementList tk_return Expression tk_dotcoma tk_close_bracket
    {
        printf("[B] MethodDeclaration ");
        $$ = new Node("MethodDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($3);
        $$->children.push_back($5);
        $$->children.push_back($8);
        $$->children.push_back($10);
    }
    | tk_public Type Identifier tk_open_parenthesis tk_close_parenthesis tk_open_bracket VarDeclarationList StatementList tk_return Expression tk_dotcoma tk_close_bracket
    {
        printf("[B] MethodDeclaration ");
        $$ = new Node("MethodDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($3);
        $$->children.push_back($7);
        $$->children.push_back($8);
        $$->children.push_back($10);
    }
    | tk_public Type Identifier tk_open_parenthesis tk_close_parenthesis tk_open_bracket StatementList tk_return Expression tk_dotcoma tk_close_bracket
    {
        printf("[B] MethodDeclaration ");
        $$ = new Node("MethodDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($3);
        $$->children.push_back($7);
        $$->children.push_back($9);
    }
    | tk_public Type Identifier tk_open_parenthesis TypeIdComaTypeId tk_close_parenthesis tk_open_bracket VarDeclarationList tk_return Expression tk_dotcoma tk_close_bracket
    {
        printf("[B] MethodDeclaration ");
        $$ = new Node("MethodDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($3);
        $$->children.push_back($5);
        $$->children.push_back($8);
        $$->children.push_back($10);
    }
    | tk_public Type Identifier tk_open_parenthesis TypeIdComaTypeId tk_close_parenthesis tk_open_bracket tk_return Expression tk_dotcoma tk_close_bracket
    {
        printf("[B] MethodDeclaration ");
        $$ = new Node("MethodDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($3);
        $$->children.push_back($5);
        $$->children.push_back($9);
    }
    | tk_public Type Identifier tk_open_parenthesis tk_close_parenthesis tk_open_bracket VarDeclarationList tk_return Expression tk_dotcoma tk_close_bracket
    {
        printf("[B] MethodDeclaration ");
        $$ = new Node("MethodDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($3);
        $$->children.push_back($7);
        $$->children.push_back($9);
    }
    | tk_public Type Identifier tk_open_parenthesis tk_close_parenthesis tk_open_bracket tk_return Expression tk_dotcoma tk_close_bracket
    {
        printf("[B] MethodDeclaration ");
        $$ = new Node("MethodDeclaration", "");
        $$->children.push_back($2);
        $$->children.push_back($3);
        $$->children.push_back($8);
    }
    ;
    
Type: tk_type_int tk_open_sbracket tk_close_sbracket
        {
            printf("[B] Type - Array ");
            $$ = new Node("TypeIntBracket", "");
        }
    | tk_type_boolean
        {
            printf("[B] Type - Bool ");
            $$ = new Node("TypeBoolean", "");
        }
    | tk_type_int
        {
            printf("[B] Type - Int ");
            $$ = new Node("TypeInt", "");
        }
    | Identifier
        {
            printf("[B] Type - Identifier ");
            $$ = new Node("Type", "");
            $$->children.push_back($1);
        }
    ;

StatementList: Statement
            {
                $$ = $1;
            }
        | StatementList Statement
            {
                $$ = new Node("StatementList", "");
                $$->children.push_back($1);
                $$->children.push_back($2);
            }
        ;
    
Statement: tk_open_bracket StatementList tk_close_bracket
        {
            printf("[B] Statement - {Statement}");
            $$ = new Node("Statement", "");
            $$->children.push_back($2);
        }
    | tk_open_bracket tk_close_bracket
        {
            printf("[B] Statement - {Statement}");
            $$ = new Node("StatementEmptyBracket", "");;
        }  
    | tk_if tk_open_parenthesis Expression tk_close_parenthesis Statement tk_else Statement
        {
            printf("[B] Statement - If");
            $$ = new Node("Statement", "");
            $$->children.push_back($3);
            $$->children.push_back($5);
            $$->children.push_back($7);
        }
    | tk_while tk_open_parenthesis Expression tk_close_parenthesis Statement
        {
            printf("[B] Statement - While");
            $$ = new Node("Statement", "");
            $$->children.push_back($3);
            $$->children.push_back($5);
        }
    | tk_sop tk_open_parenthesis Expression tk_close_parenthesis tk_dotcoma
        {
            printf("[B] Statement - Sout");
            $$ = $3;
        }
    | Identifier tk_equals Expression tk_dotcoma //////////////////////////////////
        {
            printf("[B] Statement - Equals");
            $$ = new Node("Statement equals", "");
            $$->children.push_back($1);
            $$->children.push_back($3);
        }
    | Identifier tk_open_sbracket Expression tk_close_sbracket tk_equals Expression tk_dotcoma
        {
            printf("[B] Statement - Equals array");
            $$ = new Node("Statement", "");
            $$->children.push_back($1);
            $$->children.push_back($3);
        }
    ;

ComaExp: tk_coma Expression 
        {
            $$ = $2;
        }
    | ComaExp tk_coma ComaExp
        {
            $$ = new Node("ComaExp", "");
            $$->children.push_back($1);
            $$->children.push_back($3);
        }
    ;

ExpComaExp: Expression ComaExp
        {
            $$ = new Node("ExpComaExp", "");
            $$->children.push_back($1);
            $$->children.push_back($2);
        }
        | Expression
        {
            $$ = new Node("ExpComaExp", "");
            $$->children.push_back($1);
        }
    ;

Expression: Expression tk_and Expression
        {
            printf("[B] Expression - And ");
            $$ = new Node("Expression", "");
            $$->children.push_back($1);
            $$->children.push_back($3);
        }
    | Expression tk_relop Expression
        {
            printf("[B] Expression - Relop ");
            $$ = new Node("Expression", "");
            $$->children.push_back($1);
            $$->children.push_back($3);
        }
    | Expression tk_plus Expression
        {
            printf("[B] Expression - Plus ");
            $$ = new Node("ExpressionPlus", "");
            $$->children.push_back($1);
            $$->children.push_back($3);
        }
    | Expression tk_minus Expression
        {
            printf("[B] Expression - Minus ");
            $$ = new Node("ExpressionMinus", "");
            $$->children.push_back($1);
            $$->children.push_back($3);
        }
    | Expression tk_multiply Expression
        {
            printf("[B] Expression - Multiply ");
            $$ = new Node("ExpressionMult", "");
            $$->children.push_back($1);
            $$->children.push_back($3);
        }
    | Expression tk_open_sbracket Expression tk_close_sbracket
        {
            $$ = new Node("ExpresssionSBracket", "");
            $$->children.push_back($1);
            $$->children.push_back($3);
        }
    | Expression tk_dot tk_length
        {
            printf("[B] Expression - Expression.length ");
            $$ = $1;
        }
    | Expression tk_dot Identifier tk_open_parenthesis ExpComaExp tk_close_parenthesis
        {
            printf("[B] Expression - Expression.Identifier(Expression,Expression)) ");
            $$ = new Node("ExpressionIdentifier", "");
            $$->children.push_back($1);
            $$->children.push_back($3);
            $$->children.push_back($5);
        }
    | Expression tk_dot Identifier tk_open_parenthesis tk_close_parenthesis
        {
            printf("[B] Expression - Expression.Identifier(Expression,Expression)) ");
            $$ = new Node("ExpressionIdentifier", "");
            $$->children.push_back($1);
            $$->children.push_back($3);
        }
    | tk_cifra
        {
            printf("[B] Expression - INTEGER_LITERAL ");
            $$ = new Node("Integer Literal", "$1");
        }
    | tk_true
        {
            printf("[B] Expression - True ");
            $$ = new Node("True", "");
        }
    | tk_false
        {
            printf("[B] Expression - False ");
            $$ = new Node("False", "");
        }
    | Identifier
        {
            printf("[B] Expression - Identifier ");
            $$ = $1;
        }
    | tk_this
        {
            printf("[B] Expression - This ");
            $$ = new Node("This", "");
        }
    | tk_new tk_type_int tk_open_sbracket Expression tk_close_sbracket
        {
            printf("[B] Expression - new int [ Expresssion ] ");
            $$ = $4;
        }
    | tk_new Identifier tk_open_parenthesis tk_close_parenthesis
        {
            printf("[B] Expression - new Identifier () ");
            $$ = $2;
        }
    | tk_exclamation Expression
        {
            printf("[B] Expression - ! Expression ");
            $$ = $2;
        }
    | tk_open_parenthesis Expression tk_close_parenthesis
        {
            printf("[B] Expression - ( Expression ) ");
            $$ = $2;
        }
    ;
    
Identifier: tk_identifier
        {
            
            printf("[B] Identifier ");
            $$ = new Node("Identifier ", $1);
        }
    ;
    

