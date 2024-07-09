import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpExchange;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;

public class Projectanmol{
    public static void main(String[] args) throws IOException {
        int serverPort = 8000; // Port number for the server to listen on
        HttpServer server = HttpServer.create(new InetSocketAddress(serverPort), 0);
        
        server.createContext("/", new RootHandler()); // Handle requests to "/"
        
        server.setExecutor(null); // Use default executor
        
        System.out.println("Starting server on port " + serverPort + "...");
        server.start();
    }
    
    static class RootHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            // HTML content for the webpage
            String response = "<html>\n" +
                              "<head><title>Education</title></head>\n" +
                              "<body>\n" +
                              "<h1>Education</h1>\n" +
                              "<p>Education is the process of acquiring knowledge, skills, values, beliefs, and habits. " +
                              "It is a lifelong process that begins in early childhood and continues throughout one's life. " +
                              "Education can take place in formal settings such as schools and universities, as well as through " +
                              "informal means like self-study and experience.</p>\n" +
                              "<p>In today's world, education is essential for personal development, social progress, " +
                              "and economic growth. It empowers individuals to achieve their goals, contribute to society, " +
                              "and adapt to a rapidly changing global environment.</p>\n" +
                              "</body>\n" +
                              "</html>";
            
            // Set the response headers and send the response
            exchange.sendResponseHeaders(200, response.getBytes().length);
            OutputStream os = exchange.getResponseBody();
            os.write(response.getBytes());
            os.close();
        }
    }
}
