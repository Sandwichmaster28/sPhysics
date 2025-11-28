import React from 'react';
import { Atom, CheckCircle2, AlertTriangle, Cpu } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";
import { Badge } from "@/components/ui/badge";

export default function Physics() {
  return (
    <div className="max-w-4xl mx-auto space-y-10">
      
      {/* Header */}
      <div className="space-y-4">
        <div className="flex items-center gap-2 text-blue-400 mb-2">
          <Atom className="w-5 h-5" />
          <span className="font-mono text-sm uppercase tracking-wider">Core Module</span>
        </div>
        <h1 className="text-4xl font-bold text-zinc-100">Physics Engine</h1>
        <p className="text-xl text-zinc-400 leading-relaxed">
          A parallel processing layer that runs alongside the default Roblox Physics engine, providing real-time error correction and granular control over environmental constants.
        </p>
      </div>

      <Separator className="bg-zinc-800" />

      {/* Main Features Grid */}
      <div className="grid md:grid-cols-2 gap-6">
        <Card className="bg-zinc-900/30 border-zinc-800">
          <CardHeader>
            <CardTitle className="text-zinc-100 flex items-center gap-2">
              <CheckCircle2 className="w-5 h-5 text-green-500" />
              Parallel Correction
            </CardTitle>
          </CardHeader>
          <CardContent className="text-zinc-400 text-sm leading-6">
            The engine monitors rigid body states every frame. When the default solver introduces micro-errors (floating point drift), our engine instantly snaps the object back to its mathematically correct trajectory without visual stuttering.
          </CardContent>
        </Card>

        <Card className="bg-zinc-900/30 border-zinc-800">
          <CardHeader>
            <CardTitle className="text-zinc-100 flex items-center gap-2">
              <Cpu className="w-5 h-5 text-blue-500" />
              Workspace Control
            </CardTitle>
          </CardHeader>
          <CardContent className="text-zinc-400 text-sm leading-6">
            Direct override capability for global Workspace settings. Manipulate Gravity, AirDensity, and GlobalFriction in real-time via the API, bypassing standard replication delays.
          </CardContent>
        </Card>
      </div>

      {/* Code/Technical Section */}
      <div className="space-y-6">
        <h2 className="text-2xl font-semibold text-zinc-200">Implementation Details</h2>
        <Card className="bg-zinc-950 border-zinc-800 font-mono text-sm">
          <div className="flex border-b border-zinc-800">
            <div className="px-4 py-2 bg-zinc-900 text-zinc-300 border-r border-zinc-800">PhysicsService.lua</div>
          </div>
          <CardContent className="p-6 text-zinc-400">
            <p className="mb-4 text-zinc-500">// Example: Initializing the correction loop</p>
            <div className="space-y-1">
              <p><span className="text-purple-400">local</span> Physics <span className="text-purple-400">=</span> require(game.ServerStorage.Modules.Physics)</p>
              <p><span className="text-purple-400">local</span> CorrectionRate <span className="text-purple-400">=</span> <span className="text-orange-400">60</span> <span className="text-zinc-600">-- Hz</span></p>
              <br/>
              <p>Physics.StartParallelProcess(<span className="text-purple-400">function</span>(delta)</p>
              <p className="pl-4"><span className="text-purple-400">local</span> drift <span className="text-purple-400">=</span> Workspace.Gravity <span className="text-purple-400">-</span> Physics.ExpectedGravity</p>
              <p className="pl-4"><span className="text-purple-400">if</span> math.abs(drift) <span className="text-purple-400">{'>'}</span> <span className="text-orange-400">0.001</span> <span className="text-purple-400">then</span></p>
              <p className="pl-8">Physics.ForceCorrect(Workspace, drift)</p>
              <p className="pl-4"><span className="text-purple-400">end</span></p>
              <p><span className="text-purple-400">end</span>)</p>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Warning/Notes */}
      <div className="bg-zinc-900/50 border border-zinc-800 rounded-lg p-4 flex gap-4">
        <AlertTriangle className="w-6 h-6 text-yellow-500 shrink-0" />
        <div>
          <h4 className="text-zinc-200 font-medium mb-1">Resource Usage Warning</h4>
          <p className="text-sm text-zinc-500">
            Enabling full correction mode on over 500 active rigid bodies may impact server heartbeat. 
            It is recommended to use <span className="bg-zinc-800 px-1 py-0.5 rounded text-zinc-300">Zone-Based Correction</span> for large maps.
          </p>
        </div>
      </div>

    </div>
  );
}