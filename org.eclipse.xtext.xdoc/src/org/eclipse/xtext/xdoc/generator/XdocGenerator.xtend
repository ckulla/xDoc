package org.eclipse.xtext.xdoc.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.generator.IGenerator

class XdocGenerator implements IGenerator {
	
	override void doGenerate(Resource input, IFileSystemAccess fsa) {
		for (g : generators) {
			try {
				g.doGenerate (input, fsa)				
			} catch (Throwable t) {
				println (t)
				t.printStackTrace
			}
		}
	}
	
	def Iterable<? extends IGenerator> getGenerators () {
		newArrayList()
	}

}