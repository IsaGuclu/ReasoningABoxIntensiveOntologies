import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import org.semanticweb.elk.owlapi.ElkReasonerFactory;
import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.formats.FunctionalSyntaxDocumentFormat;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLAxiom;
import org.semanticweb.owlapi.model.OWLOntology;
import org.semanticweb.owlapi.model.OWLOntologyCreationException;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.semanticweb.owlapi.model.OWLOntologyStorageException;
import org.semanticweb.owlapi.reasoner.InferenceType;
import org.semanticweb.owlapi.reasoner.OWLReasoner;
import org.semanticweb.owlapi.reasoner.OWLReasonerFactory;
import org.semanticweb.owlapi.util.InferredAxiomGenerator;
import org.semanticweb.owlapi.util.InferredEquivalentClassAxiomGenerator;
import org.semanticweb.owlapi.util.InferredOntologyGenerator;
import org.semanticweb.owlapi.util.InferredSubClassAxiomGenerator;

public class TimeHarvester {

	static String CSV_HEADER = "OntologyURI;ReasonerCreationTime(ns);MaterializingTime(ns)";;

	// args[0] == Ontology IRI
	
	public static void main(String[] args) throws Exception {
		
		File dFile = new File(args[0]);
		String dFilePath = dFile.getAbsolutePath().substring(0, dFile.getAbsolutePath().lastIndexOf(File.separator));

		File outFile = new File(dFilePath + File.separator + "ELK_Times.csv");
		PrintWriter out = null;
		if (outFile.exists()) {
			out = new PrintWriter(new FileWriter(outFile, true));
		} else {
			out = new PrintWriter(new FileWriter(outFile));
			out.println(CSV_HEADER);
		}

		File errorFile = new File(dFilePath + File.separator + "ELK_TimesError.csv");
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
			OWLOntologyManager om = null;
			OWLOntology ont = null;			
			OWLReasonerFactory reasonerFactory = null;
			OWLReasoner reasoner = null;

			System.err.println("Processing " + inputLine);

			om = OWLManager.createOWLOntologyManager();

			// if the input is not a URI, we assume that is is a local path
			if (!(inputLine.startsWith("http://") || inputLine.startsWith("file://"))) {
				inputLine = "file:///" + inputLine;
			}

			ont = om.loadOntologyFromOntologyDocument(IRI.create(inputLine));
			
			// we also measure the reasoner creation time
			// as the creation of the inner structures might affect
			// the actual reasoning times
			start = System.nanoTime();
		
			// Create an ELK reasoner.
			reasonerFactory = new ElkReasonerFactory();
			reasoner = reasonerFactory.createReasoner(ont);

			creationTime = System.nanoTime() - start;

			System.err.println("-->Materializing");
			// Materialising the inferences
			start = System.nanoTime();
			reasoner.precomputeInferences(InferenceType.CLASS_HIERARCHY);

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
