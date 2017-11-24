import java.util.Set;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.MultiMap;
import org.antlr.v4.runtime.misc.OrderedHashSet;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.stringtemplate.v4.ST;

import java.io.FileInputStream;
import java.io.InputStream;
public class FunctionListener extends JavaBaseListener{
   static class Graph {
        
        Set<String> nodes = new OrderedHashSet<String>(); 
        MultiMap<String, String> edges =                  
            new MultiMap<String, String>();
        public void edge(String source, String target) {
            edges.map(source, target);
        }
        public String toString() {
            return "edges: "+edges.toString()+", functions: "+ nodes;
        }
        public String toDOT() {
            StringBuilder buf = new StringBuilder();
            buf.append("digraph G {\n");
            buf.append("  ranksep=.25;\n");
            buf.append("  edge [arrowsize=.5]\n");
            buf.append("  node [shape=circle, fontname=\"ArialNarrow\",\n");
            buf.append("        fontsize=12, fixedsize=true, height=.45];\n");
            buf.append("  ");
            for (String node : nodes) { // print all nodes first
                buf.append(node);
                buf.append("; ");
            }
            buf.append("\n");
            for (String src : edges.keySet()) {
                for (String trg : edges.get(src)) {
                    buf.append("  ");
                    buf.append(src);
                    buf.append(" -> ");
                    buf.append(trg);
                    buf.append(";\n");
                }
            }
            buf.append("}\n");
            return buf.toString();
        }

    }

        Graph graph = new Graph();
        String currentFunctionName = null;

        @Override
        public void enterMethodDecl(JavaParser.MethodDeclContext ctx) {
            currentFunctionName = ctx.ID().getText();
            graph.nodes.add(currentFunctionName);
        }

        @Override
        public void exitMethodCall(JavaParser.MethodCallContext ctx) {
            String funcName = ctx.ID().getText();
            // map current function to the callee
            graph.edge(currentFunctionName, funcName);
        }
   
}