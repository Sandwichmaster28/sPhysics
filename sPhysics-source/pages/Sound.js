import React, { useState } from 'react';
import { Music, Speaker, Radio, Settings2, Volume2, Wind } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import { Switch } from "@/components/ui/switch";
import { Label } from "@/components/ui/label";
import { Separator } from "@/components/ui/separator";

export default function Sound() {
  const [mode, setMode] = useState('custom'); // 'default' or 'custom'

  return (
    <div className="max-w-4xl mx-auto space-y-10">
      
      {/* Header */}
      <div className="space-y-4">
        <div className="flex items-center gap-2 text-emerald-400 mb-2">
          <Music className="w-5 h-5" />
          <span className="font-mono text-sm uppercase tracking-wider">Audio Module</span>
        </div>
        <div className="flex justify-between items-end">
          <div>
            <h1 className="text-4xl font-bold text-zinc-100">Sound Engine</h1>
            <p className="text-xl text-zinc-400 leading-relaxed mt-4 max-w-2xl">
              A dual-mode audio system handling procedural impact sounds, environmental ambience, and dynamic footstep generation.
            </p>
          </div>
          <div className="hidden md:block">
             <div className="bg-zinc-900 p-4 rounded-xl border border-zinc-800 flex flex-col gap-2 w-64">
                <div className="flex justify-between items-center">
                    <span className="text-xs font-mono text-zinc-500">ACTIVE API</span>
                    <div className={`w-2 h-2 rounded-full ${mode === 'custom' ? 'bg-emerald-500' : 'bg-blue-500'}`}></div>
                </div>
                <div className="font-bold text-zinc-200">{mode === 'custom' ? 'Custom Raycast' : 'Roblox Default'}</div>
             </div>
          </div>
        </div>
      </div>

      <Separator className="bg-zinc-800" />

      {/* API Mode Selection & Explanation */}
      <Card className="bg-zinc-950 border-zinc-800">
        <CardHeader className="pb-2">
            <CardTitle className="text-zinc-200">API Selection</CardTitle>
        </CardHeader>
        <CardContent>
            <Tabs defaultValue="custom" className="w-full" onValueChange={setMode}>
              <TabsList className="grid w-full grid-cols-2 bg-zinc-900">
                <TabsTrigger value="default">Default API (Experimental)</TabsTrigger>
                <TabsTrigger value="custom">Custom API (Raycasted)</TabsTrigger>
              </TabsList>
              
              <TabsContent value="default" className="mt-6 space-y-4">
                <div className="flex gap-4 p-4 bg-blue-950/20 border border-blue-900/50 rounded-lg">
                    <Speaker className="w-6 h-6 text-blue-400 shrink-0 mt-1" />
                    <div>
                        <h3 className="font-medium text-blue-400">Roblox Native Integration</h3>
                        <p className="text-sm text-zinc-400 mt-1">
                            Uses Roblox's built-in experimental audio API. Best for performance on lower-end devices but lacks accurate occlusion and real-time echo calculation.
                        </p>
                    </div>
                </div>
              </TabsContent>

              <TabsContent value="custom" className="mt-6 space-y-4">
                <div className="flex gap-4 p-4 bg-emerald-950/20 border border-emerald-900/50 rounded-lg">
                    <Radio className="w-6 h-6 text-emerald-400 shrink-0 mt-1" />
                    <div>
                        <h3 className="font-medium text-emerald-400">Raycasted Propagation</h3>
                        <p className="text-sm text-zinc-400 mt-1">
                            The Sound Engine's proprietary code. Casts rays from the source to the listener to calculate muffling, reverb, and echo in real-time based on material density.
                        </p>
                    </div>
                </div>
              </TabsContent>
            </Tabs>
        </CardContent>
      </Card>

      {/* Features Grid */}
      <div className="grid md:grid-cols-3 gap-6">
        <div className="bg-zinc-900/30 p-6 rounded-xl border border-zinc-800 space-y-3">
            <div className="w-10 h-10 bg-zinc-800 rounded-lg flex items-center justify-center">
                <Volume2 className="w-5 h-5 text-zinc-300" />
            </div>
            <h3 className="font-bold text-zinc-200">Impact Sounds</h3>
            <p className="text-sm text-zinc-500">
                Calculates velocity and material type upon collision to play the correct impact or breaking sound (Glass, Wood, Metal).
            </p>
        </div>

        <div className="bg-zinc-900/30 p-6 rounded-xl border border-zinc-800 space-y-3">
            <div className="w-10 h-10 bg-zinc-800 rounded-lg flex items-center justify-center">
                <Settings2 className="w-5 h-5 text-zinc-300" />
            </div>
            <h3 className="font-bold text-zinc-200">Footstep System</h3>
            <p className="text-sm text-zinc-500">
                Dynamic texture detection under character feet. Supports varying walk speeds and gear rattle layers.
            </p>
        </div>

        <div className="bg-zinc-900/30 p-6 rounded-xl border border-zinc-800 space-y-3">
            <div className="w-10 h-10 bg-zinc-800 rounded-lg flex items-center justify-center">
                <Wind className="w-5 h-5 text-zinc-300" />
            </div>
            <h3 className="font-bold text-zinc-200">Ambient & Wind</h3>
            <p className="text-sm text-zinc-500">
                Procedural wind that reacts to altitude and enclosed spaces. Zone-based ambient tracks with smooth crossfading.
            </p>
        </div>
      </div>
    </div>
  );
}