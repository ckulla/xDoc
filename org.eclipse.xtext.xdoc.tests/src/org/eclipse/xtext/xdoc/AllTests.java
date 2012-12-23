package org.eclipse.xtext.xdoc;

import org.eclipse.xtext.xdoc.generator.util.UtilsTest;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

@RunWith(Suite.class)
@SuiteClasses({
	LexerTest.class,
	ParserTest.class,
	UtilsTest.class
})
public class AllTests {
}
