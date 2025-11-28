import React from 'react';
import { Database, Globe, Server, ShieldCheck, ArrowUpRight, ArrowDownLeft } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";

export default function Data() {
  return (
    <div className="max-w-4xl mx-auto space-y-10">
      
      {/* Header */}
      <div className="space-y-4">
        <div className="flex items-center gap-2 text-orange-400 mb-2">
          <Database className="w-5 h-5" />
          <span className="font-mono text-sm uppercase tracking-wider">Network Module</span>
        </div>
        <h1 className="text-4xl font-bold text-zinc-100">Data Get/Post</h1>
        <p className="text-xl text-zinc-400 leading-relaxed">
            The central nervous system for information flow. Manages internal game replication via RemoteFunctions and external communication via secure HTTP requests.
        </p>
      </div>

      <Separator className="bg-zinc-800" />

      <div className="grid md:grid-cols-2 gap-8">
        
        {/* Game Data Section */}
        <div className="space-y-6">
            <Card className="bg-zinc-900/30 border-zinc-800 h-full">
                <CardHeader>
                    <CardTitle className="text-zinc-100 flex items-center gap-2">
                        <Server className="w-5 h-5 text-orange-500" />
                        Internal Game Data
                    </CardTitle>
                </CardHeader>
                <CardContent className="space-y-6">
                    <p className="text-zinc-400 text-sm leading-relaxed">
                        Handles replication between Client and Server using optimized RemoteFunctions. Data is compressed before transmission to reduce bandwidth usage.
                    </p>
                    
                    <div className="space-y-3">
                        <div className="flex items-center gap-3 p-3 bg-zinc-950 rounded border border-zinc-800">
                            <ArrowUpRight className="w-4 h-4 text-zinc-500" />
                            <div>
                                <div className="text-xs text-zinc-500 font-mono">POST (Client → Server)</div>
                                <div className="text-zinc-300 text-sm">PlayerData.Save(Slot1)</div>
                            </div>
                        </div>
                        <div className="flex items-center gap-3 p-3 bg-zinc-950 rounded border border-zinc-800">
                            <ArrowDownLeft className="w-4 h-4 text-zinc-500" />
                            <div>
                                <div className="text-xs text-zinc-500 font-mono">GET (Server → Client)</div>
                                <div className="text-zinc-300 text-sm">GlobalLeaderboard.Fetch()</div>
                            </div>
                        </div>
                    </div>
                </CardContent>
            </Card>
        </div>

        {/* HTTP Section */}
        <div className="space-y-6">
            <Card className="bg-zinc-900/30 border-zinc-800 h-full">
                <CardHeader>
                    <CardTitle className="text-zinc-100 flex items-center gap-2">
                        <Globe className="w-5 h-5 text-blue-500" />
                        External HTTP Requests
                    </CardTitle>
                </CardHeader>
                <CardContent className="space-y-6">
                    <p className="text-zinc-400 text-sm leading-relaxed">
                        Interfaces with external APIs (Discord Webhooks, Trello, Custom DBs). Includes built-in rate limiting and retry logic for failed requests.
                    </p>

                    <div className="p-4 bg-zinc-950 rounded border border-zinc-800">
                        <div className="flex items-center gap-2 mb-2">
                            <ShieldCheck className="w-4 h-4 text-green-500" />
                            <span className="text-sm font-medium text-zinc-200">Security Protocol</span>
                        </div>
                        <p className="text-xs text-zinc-500">
                            All HTTP requests are routed through a proxy server to hide the game instance IP and prevent DDoS attacks.
                        </p>
                    </div>
                </CardContent>
            </Card>
        </div>

      </div>

      {/* Code Snippet */}
      <div className="space-y-4 pt-6">
        <h3 className="text-zinc-300 font-medium">API Usage Example</h3>
        <div className="bg-zinc-950 border border-zinc-800 rounded-lg p-4 overflow-x-auto">
            <pre className="text-xs font-mono text-zinc-400">
<span className="text-orange-400">local</span> DataService = require(Modules.Data)

<span className="text-zinc-500">-- GET Data</span>
<span className="text-orange-400">local</span> profile = DataService:Get(<span className="text-green-400">"Player_123"</span>, <span className="text-green-400">"Inventory"</span>)

<span className="text-zinc-500">-- POST HTTP</span>
DataService:PostHTTP(<span className="text-green-400">"https://api.example.com/log"</span>, &#123;
    event = <span className="text-green-400">"ServerStart"</span>,
    timestamp = os.time()
&#125;)</pre>
        </div>
      </div>

    </div>
  );
}