package org.eclipse.xtext.xdoc.generator.util

import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.util.StopWatch
import org.eclipse.xtext.xdoc.generator.util.Utils
import org.eclipse.xtext.xdoc.xdoc.CodeBlock
import org.eclipse.xtext.xdoc.xdoc.LangDef
import org.eclipse.xtext.xdoc.xdoc.XdocFactory
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.eclipse.xtext.xdoc.XdocInjectorProvider

import static extension org.junit.Assert.*
import com.google.inject.Inject

@RunWith(typeof(XtextRunner))
@InjectWith(typeof(XdocInjectorProvider))
public class UtilsTest {

	@Inject
	Utils utils

	LangDef testLangDef

	private String[] testKeyWords = newArrayList("grammar", "with", "import", "terminal", "returns")

	private String testCodeString =	
		'''
		class Foo {
			static int foo = 13;
		}
		
		  '''.toString

	private CodeBlock testCodeBlock

	@Before
	def void setUp() {
		testLangDef = XdocFactory::eINSTANCE.createLangDef
		testLangDef.keywords += testKeyWords

		testCodeBlock = XdocFactory::eINSTANCE.createCodeBlock
		val testCode = XdocFactory::eINSTANCE.createCode
		testCode.contents = testCodeString
		testCodeBlock.contents += testCode
	}

	@Test	
	def testFormatCode_00() {
		var code = ""
		val watch = new StopWatch()
		for (i : 0..1) {
			code = utils.formatCode("mein foo ist bar nicht baz.", langDef)
		}
		watch.resetAndLog("keywords")
		assertEquals("mein&nbsp;<span class=\"keyword\">foo</span>&nbsp;ist&nbsp;<span class=\"keyword\">bar</span>&nbsp;nicht&nbsp;<span class=\"keyword\">baz</span>.", code)
	}

	@Test
	def testFormatCode_01() {
		val code = utils.formatCode("/* mein foo ist bar nicht baz.*/", langDef)
		assertEquals("<span class=\"comment\">/*&nbsp;mein&nbsp;foo&nbsp;ist&nbsp;bar&nbsp;nicht&nbsp;baz.*/</span>", code)
	}
	
	@Test
	def testFormatCode_02() {
		val code = utils.formatCode("' mein foo ist bar nicht baz.'", langDef)
		assertEquals("<span class=\"string\">&apos;&nbsp;mein&nbsp;foo&nbsp;ist&nbsp;bar&nbsp;nicht&nbsp;baz.&apos;</span>", code)
	}
	
	@Test
	def testFormatCode_03() {
		val code = utils.formatCode("' mein foo ist bar nicht baz.'", null)
		assertEquals ("<span class=\"string\">&apos;&nbsp;mein&nbsp;foo&nbsp;ist&nbsp;bar&nbsp;nicht&nbsp;baz.&apos;</span>", code)
	}

	@Test	
	def testFormatCode_04() {
		val code = utils.formatCode("/* mein foo ist bar nicht baz.", null)
		assertEquals ("/*&nbsp;mein&nbsp;foo&nbsp;ist&nbsp;bar&nbsp;nicht&nbsp;baz.", code)
	}

	@Test
	def testFormatCode_05() {
		val code = utils.formatCode("'\\[mein\\]'", null)
		assertEquals ("<span class=\"string\">&apos;[mein]&apos;</span>", code)
	}

	def create XdocFactory::eINSTANCE.createLangDef langDef() {
		langDef.keywords += newArrayList("foo", "bar", "baz", "dfsdf", "wweee", "dsfsd")
	}
}
