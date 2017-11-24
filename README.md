Java.g4 is the main grammar file.
CallGraph.java and FunctionListener.java are used to generate output.
#runnig the code:
1-antlr4 Java.g4 
2-javac Java*.java CallGraph.java
3-java CallGraph input_file_name.java