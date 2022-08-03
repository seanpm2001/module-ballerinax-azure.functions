package org.ballerinax.azurefunctions;

import io.ballerina.compiler.syntax.tree.FunctionDefinitionNode;
import io.ballerina.compiler.syntax.tree.IdentifierToken;
import io.ballerina.compiler.syntax.tree.Node;
import io.ballerina.compiler.syntax.tree.NodeList;
import io.ballerina.compiler.syntax.tree.ResourcePathParameterNode;
import io.ballerina.compiler.syntax.tree.ServiceDeclarationNode;
import io.ballerina.compiler.syntax.tree.SyntaxKind;
import io.ballerina.compiler.syntax.tree.Token;

import java.util.ArrayList;
import java.util.List;

import static org.ballerinax.azurefunctions.Util.resourcePathToString;

/**
 * Responsible for generating Azure function name for each resource function.
 * 
 * @since 2.0.0
 */
public class AzureFunctionNameGenerator {

    private List<String> functionNames = new ArrayList<>();
    private List<String> generatedNames = new ArrayList<>();

    public AzureFunctionNameGenerator(ServiceDeclarationNode serviceDeclarationNode) {
        NodeList<Node> members = serviceDeclarationNode.members();
        String servicePath = resourcePathToString(serviceDeclarationNode.absoluteResourcePath());
        for (Node node : members) {
            if (node.kind() != SyntaxKind.RESOURCE_ACCESSOR_DEFINITION) {
                continue;
            }
            FunctionDefinitionNode functionDefinitionNode = (FunctionDefinitionNode) node;
            String method = functionDefinitionNode.functionName().text();
            StringBuilder resourcePath = new StringBuilder();
            resourcePath.append(servicePath);
            for (Node pathBlock : functionDefinitionNode.relativeResourcePath()) {
                if (pathBlock.kind() == SyntaxKind.IDENTIFIER_TOKEN) {
                    resourcePath.append("/").append(((IdentifierToken) pathBlock).text());
                } else if (pathBlock.kind() == SyntaxKind.RESOURCE_PATH_SEGMENT_PARAM) {
                    Token token = ((ResourcePathParameterNode) pathBlock).paramName();
                    resourcePath.append("/").append(token.text());
                }
            }
            String functionName = method + "-" + resourcePath.toString().replace("/", "-");
            this.functionNames.add(functionName);
        }
    }

    public String getUniqueFunctionName(String servicePath, FunctionDefinitionNode functionDefinitionNode) {
        String method = functionDefinitionNode.functionName().text();
        StringBuilder resourcePath = new StringBuilder();
        resourcePath.append(servicePath);
        for (Node pathBlock : functionDefinitionNode.relativeResourcePath()) {
            if (pathBlock.kind() == SyntaxKind.IDENTIFIER_TOKEN) {
                resourcePath.append("/").append(((IdentifierToken) pathBlock).text());
                continue;
            }
            if (pathBlock.kind() == SyntaxKind.RESOURCE_PATH_SEGMENT_PARAM) {
                Token token = ((ResourcePathParameterNode) pathBlock).paramName();
                resourcePath.append("/").append(token.text());

//                    resourcePath.append("{").append(pathParamNode.paramName().text()).append("}");
                continue;
            }
        }
        String functionName = method + "-" + resourcePath.toString().replace("/", "-");
        functionName = generateUniqueName(functionName, 0);
        generatedNames.add(functionName);
        return functionName;
    }

    private String generateUniqueName(String initialName, int index) {
        String newName;
        if (index == 0) {
            newName = initialName;
        } else {
            newName = initialName + "-" + index;
        }

        if (!isDuplicateName(newName)) {
            return newName;
        }
        return generateUniqueName(initialName, index + 1);
    }

    private boolean isDuplicateName(String initialName) {
        int count = 0;
        for (String functionName : this.functionNames) {
            if (functionName.equals(initialName)) {
                count++;
            }
        }
        return generatedNames.contains(initialName) || count > 1;
    }
}
