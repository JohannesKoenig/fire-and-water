from http import server

'''Run this script in the folder of the web build'''

class MyHTTPRequestHandler(server.SimpleHTTPRequestHandler):
        def end_headers(self):
                self.send_my_headers()
                server.SimpleHTTPRequestHandler.end_headers(self)

        def send_my_headers(self):
                self.send_header("Access-Control-Allow-Origin", "*")
                self.send_header("Cross-Origin-Embedder-Policy", "require-corp")
                self.send_header("Cross-Origin-Opener-Policy", "same-origin")

if __name__ == '__main__':
        server.test(HandlerClass=MyHTTPRequestHandler)