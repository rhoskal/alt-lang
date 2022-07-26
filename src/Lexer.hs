module Lexer where

import           RIO
import           Text.Megaparsec
import           Text.Megaparsec.Char
import qualified Text.Megaparsec.Char.Lexer    as L
import           Types


lineComment :: Parser ()
lineComment = L.skipLineComment "--"


blockComment :: Parser ()
blockComment = L.skipBlockComment "{-" "-}"


sc :: Parser ()
sc = L.space space1 lineComment blockComment
-- sc = L.space (void $ some (char ' ' <|> char '\t')) lineComment blockComment


-- scn :: Parser ()
-- scn = L.space space1 lineComment blockComment


lexeme :: Parser a -> Parser a
lexeme = L.lexeme sc


symbol :: Text -> Parser Text
symbol = L.symbol sc


integerLiteral :: Parser Integer
integerLiteral = lexeme L.decimal


floatLiteral :: Parser Double
floatLiteral = lexeme L.float


stringLiteral :: Parser String
stringLiteral = char '"' *> manyTill L.charLiteral (char '"')


binaryLiteral :: Parser Integer
binaryLiteral = char '0' >> char 'b' >> L.binary


octalLiteral :: Parser Integer
octalLiteral = char '0' >> char 'o' >> L.octal


hexadecimalLiteral :: Parser Integer
hexadecimalLiteral = char '0' >> char 'x' >> L.hexadecimal
