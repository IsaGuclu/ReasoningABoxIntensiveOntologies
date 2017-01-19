package general;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;

import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLOntology;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.semanticweb.owlapi.reasoner.InferenceType;
import org.semanticweb.owlapi.reasoner.OWLReasoner;

import eu.trowl.owlapi3.rel.reasoner.el.RELReasonerFactory;

public class TimeHarvester {

	static String CSV_HEADER = "OntologyURI;ReasonerCreationTime(ns);MaterializingTime(ns)";;

	// args[0] == Ontology IRI

	public static void main(String[] args) throws Exception {
		
		File dFile = new File(args[0]);	    
		String dFilePath = dFile.getAbsolutePath().substring(0,dFile.getAbsolutePath().lastIndexOf(File.separator));
		
		File outFile = new File(dFilePath + File.separator + "TrOWL_Times.csv");
		PrintWriter out = null;
		if (outFile.exists()) {
			out = new PrintWriter(new FileWriter(outFile, true));
		} else {
			out = new PrintWriter(new FileWriter(outFile));
			out.println(CSV_HEADER);
		}

		File errorFile = new File(dFilePath + File.separator + "TrOWL_TimesError.csv");
		PrintWriter errorOut = null;
		if (errorFile.exists()) {
			errorOut = new PrintWriter(new FileWriter(errorFile, true));
		} else {
			errorOut = new PrintWriter(new FileWriter(errorFile));
		}

		long precomputingTime = -1;
		long creationTime = -1;
		long start = -1;
		String inputLine = args[0];

		try {
			OWLOntology ont = null;
			OWLOntologyManager om = null;
			OWLReasoner reasoner = null;

			System.err.println("Processing " + inputLine);

			om = OWLManager.createOWLOntologyManager();

			// if the input is not a URI, we assume that is is a local path
			if (!(inputLine.startsWith("http://") || inputLine.startsWith("file://"))) {
				inputLine = "file:///" + inputLine;
			}

			ont = om.loadOntology(IRI.create(inputLine));

			// we also measure the reasoner creation time
			// as the creation of the inner structures might affect
			// the actual reasoning times
			start = System.nanoTime();
			RELReasonerFactory relfactory = new RELReasonerFactory();
			reasoner = relfactory.createReasoner(ont);
			creationTime = System.nanoTime() - start;

			System.err.println("-->Materializing");
			// materializing the inferences
			start = System.nanoTime();
			reasoner.precomputeInferences(InferenceType.CLASS_ASSERTIONS, InferenceType.CLASS_HIERARCHY,
					InferenceType.DATA_PROPERTY_ASSERTIONS, InferenceType.DATA_PROPERTY_HIERARCHY,
					InferenceType.DIFFERENT_INDIVIDUALS, InferenceType.DISJOINT_CLASSES,
					InferenceType.OBJECT_PROPERTY_ASSERTIONS, InferenceType.OBJECT_PROPERTY_HIERARCHY,
					InferenceType.SAME_INDIVIDUAL);
			precomputingTime = System.nanoTime() - start;
		} catch (Exception e) {
			errorOut.println(inputLine + ";" + e.getClass().getName() + ";" + e.getMessage());
			System.err.println(inputLine + " could not be processed");
		}

		out.println(inputLine + ";" + creationTime + ";" + precomputingTime);
		out.flush();
		out.close();
		errorOut.flush();
		errorOut.close();
	}

}
