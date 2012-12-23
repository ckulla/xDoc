package org.eclipse.xtext.xdoc;

import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CommonToken;
import org.eclipse.xtext.junit.AbstractXtextTests;
import org.eclipse.xtext.parser.antlr.ITokenDefProvider;
import org.eclipse.xtext.parser.antlr.Lexer;
import org.eclipse.xtext.parser.antlr.LexerBindings;
import org.eclipse.xtext.util.Pair;
import org.eclipse.xtext.util.Tuples;
import org.eclipse.xtext.xdoc.XdocStandaloneSetup;

import com.google.inject.Key;
import com.google.inject.name.Names;

public class LexerTest extends AbstractXtextTests {

	@Override
	protected void setUp() throws Exception {
		super.setUp();
		with(new XdocStandaloneSetup());
	}

	@SuppressWarnings("unchecked")
	public void testMULTI_NL() throws Exception {
		checkTokens(Tuples.create("RULE_MULTI_NL","\n\n"));
	}
	
	@SuppressWarnings("unchecked")
	public void testMULTI_NL_1() throws Exception {
		checkTokens(Tuples.create("RULE_MULTI_NL","\n\n"),
				Tuples.create("RULE_WS"," "));
	}
	
//	@SuppressWarnings("unchecked")
//	public void testMULTI_NL_withWhitespace() throws Exception {
//		checkTokens(Tuples.create("RULE_MULTI_NL","\n \n"),
//				Tuples.create("RULE_WS"," "));
//	}

	protected void checkTokens(Pair<String, String>... tokens) {
		StringBuilder builder = new StringBuilder();
		for (Pair<String, String> token : tokens) {
			builder.append(token.getSecond());
		}
		Lexer lexer = newLexer();
		lexer.setCharStream(new ANTLRStringStream(builder.toString()));
		for (Pair<String, String> pair : tokens) {
			CommonToken t = (CommonToken) lexer.nextToken();
			String actual = tokenDefProvider().getTokenDefMap().get(t.getType());
			assertEquals(pair.toString(),pair.getFirst(), actual);
			assertEquals(pair.toString(),pair.getSecond(), t.getText());
		}
	}

	protected ITokenDefProvider tokenDefProvider() {
		return get(ITokenDefProvider.class);
	}

	protected Lexer newLexer() {
		return get(Key.get(Lexer.class, Names.named(LexerBindings.RUNTIME)));
	}
}
