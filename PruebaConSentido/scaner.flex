%top{
      #include "parser.tab.hh"
      #define YY_DECL yy::parser::symbol_type yylex()
      #include "Node.h"
}

dr_letra    [A-Za-z]
dr_cifra    [0-9][0-9]*
dr_space [ \t]
dr_new_line [\n]+
dr_low_bar \_

dr_identifier {dr_letra}({dr_letra}|{dr_cifra}|{dr_low_bar})*
dr_comment "/*"(.|\n)*"*/"
dr_comment2 "//"[^(\n)]*"\n"
dr_string \"([^\"])*\"

dr_class (?i:class)
dr_public (?i:public)
dr_static (?i:static)
dr_void (?i:void)
dr_main (?i:main)
dr_var_String (?i:string)
dr_extends (?i:extends)
dr_type_int (?i:int)
dr_type_boolean (?i:boolean)
dr_if (?i:if)
dr_else (?i:else)
dr_while (?i:while)
dr_sop (?i:system.out.println)
dr_return (?i:return)
dr_open_parenthesis \(
dr_close_parenthesis \)
dr_open_bracket \{
dr_close_bracket \}
dr_open_sbracket \[
dr_close_sbracket \]
dr_and \&\&
dr_plus \+
dr_minus \-
dr_barra \/
dr_multiply \*
dr_true (?i:true)
dr_false (?i:false)
dr_this (?i:this)
dr_new (?i:new)
dr_exclamation \!
dr_relop	 \<|\=\=
dr_equals \=
dr_length (?i:length)
dr_dot \.
dr_dotcoma \;
dr_coma \,

%option noyywrap nounput batch noinput stack
%%

{dr_comment}   {
            printf( "[F] Word comment /**/ " );
            return yy::parser::make_tk_comment(yytext);
            }
            
{dr_comment2}   {
            printf( "[F] Word comment // \n" );
            return yy::parser::make_tk_comment2(yytext);
            }
            
{dr_string} {
            printf( "[F] String");
            return yy::parser::make_tk_string(yytext);
            }

{dr_class}    {
		printf( "[F] Word class " );
            return yy::parser::make_tk_class(yytext);
            }

{dr_public}    {
		printf( "[F] Word public " );
            return yy::parser::make_tk_public(yytext);
            }

{dr_static}    {
		printf( "[F] Word static " );
            return yy::parser::make_tk_static(yytext);
            }

{dr_void}    {
		printf( "[F] Word void " );
            return yy::parser::make_tk_void(yytext);
            }

{dr_main}    {
            printf( "[F] Word main " );
            return yy::parser::make_tk_main(yytext);
            }

{dr_var_String}    {
            printf( "[F] Word String %s ",yytext );
            return yy::parser::make_tk_var_String(yytext);
            }

{dr_extends}   {
            printf( "[F] Word extends " );
            return yy::parser::make_tk_extends(yytext);
            }

{dr_type_int}   {
		printf( "[F] Word type_int " );
            return yy::parser::make_tk_type_int(yytext);
            }

{dr_type_boolean}   {
            printf( "[F] Word type_boolean " );
            return yy::parser::make_tk_type_boolean(yytext);
            }

{dr_if}   {
            printf( "[F] Word if " );
            return yy::parser::make_tk_if(yytext);
            }

{dr_else}   {
            printf( "[F] Word else " );
            return yy::parser::make_tk_else(yytext);
            }

{dr_while}   {
            printf( "[F] Word while ");
            return yy::parser::make_tk_while(yytext);
            }

{dr_sop}   {
            printf( "[F] Word System.out.println " );
            return yy::parser::make_tk_sop(yytext);
            }

{dr_return}   {
            printf( "[F] Word return " );
            return yy::parser::make_tk_return(yytext);
            }

{dr_open_parenthesis}   {
            printf( "[F] Word ( " );
            return yy::parser::make_tk_open_parenthesis(yytext);
            }

{dr_close_parenthesis}   {
            printf( "[F] Word ) " );
            return yy::parser::make_tk_close_parenthesis(yytext);
            }

{dr_open_bracket}   {
            printf( "[F] Word { " );
            return yy::parser::make_tk_open_bracket(yytext);
            }

{dr_close_bracket}   {
            printf( "[F] Word } " );
            return yy::parser::make_tk_close_bracket(yytext);
            }

{dr_open_sbracket}   {
            printf( "[F] Word [ " );
            return yy::parser::make_tk_open_sbracket(yytext);
            }

{dr_close_sbracket}   {
            printf( "[F] Word ] " );
            return yy::parser::make_tk_close_sbracket(yytext);
            }

{dr_and}   {
            printf( "[F] Word && " );
            return yy::parser::make_tk_and(yytext);
            }

{dr_plus}   {
            printf( "[F] Word + " );
            return yy::parser::make_tk_plus(yytext);
            }

{dr_minus}   {
            printf( "[F] Word - " );
            return yy::parser::make_tk_minus(yytext);
            }

{dr_multiply}   {
            printf( "[F] Word * " );
            return yy::parser::make_tk_multiply(yytext);
            }

{dr_true}   {
            printf( "[F] Word true " );
            return yy::parser::make_tk_true(yytext);
            }

{dr_false}   {
            printf( "[F] Word false " );
            return yy::parser::make_tk_false(yytext);
            }

{dr_this}   {
            printf( "[F] Word this " );
            return yy::parser::make_tk_this(yytext);
            }

{dr_new}   {
            printf( "[F] Word new " );
            return yy::parser::make_tk_new(yytext);
            }

{dr_exclamation}   {
            printf( "[F] Word exclamation " );
            return yy::parser::make_tk_exclamation(yytext);
            }

{dr_relop}   {
            printf( "[F] Word relop %s ",yytext);
            return yy::parser::make_tk_relop(yytext);
            }

{dr_equals}   {
            printf( "[F] Word = " );
            return yy::parser::make_tk_equals(yytext);
            }

{dr_length}   {
            printf( "[F] Word length " );
            return yy::parser::make_tk_length(yytext);
            }

{dr_identifier}   {
            printf( "[F] Word identifier %s ",yytext );
            return yy::parser::make_tk_identifier(yytext);
            }

{dr_cifra}    {
            printf( "[F] Number %s ", yytext);
            return yy::parser::make_tk_cifra(yytext);
            }

{dr_dot}    {
            printf( "[F] Dot ");
            return yy::parser::make_tk_dot(yytext);
            }

{dr_dotcoma}    {
            printf( "[F] Dot coma ");
            return yy::parser::make_tk_dotcoma(yytext);
            }
            
{dr_coma}    {
            printf( "[F] Coma ");
            return yy::parser::make_tk_coma(yytext);
            }
            
{dr_space}    {
            }

.           printf("[F] ERROR %s NOT FOUND ", yytext);

<<EOF>>                 return yy::parser::make_END();
s
%%
