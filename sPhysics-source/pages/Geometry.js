import React from 'react';
import { Shapes, Layers, Droplets, Eraser, Image as ImageIcon } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";

export default function Geometry() {
  return (
    <div className="max-w-4xl mx-auto space-y-10">
      
      {/* Header */}
      <div className="space-y-4">
        <div className="flex items-center gap-2 text-purple-400 mb-2">
          <Shapes className="w-5 h-5" />
          <span className="font-mono text-sm uppercase tracking-wider">Geometry Module</span>
        </div>
        <h1 className="text-4xl font-bold text-zinc-100">Geometry Solver</h1>
        <p className="text-xl text-zinc-400 leading-relaxed">
            The calculation powerhouse for complex mesh interactions. Handling everything from structural integrity during destruction to fluid simulation and dynamic image application.
        </p>
      </div>

      <Separator className="bg-zinc-800" />

      <Tabs defaultValue="destruction" className="w-full">
        <TabsList className="w-full justify-start bg-transparent border-b border-zinc-800 p-0 h-auto gap-6 rounded-none">
          <TabsTrigger 
            value="destruction" 
            className="rounded-none border-b-2 border-transparent data-[state=active]:border-purple-500 data-[state=active]:bg-transparent pb-3 px-0 text-zinc-500 data-[state=active]:text-zinc-100"
          >
            Destruction Physics
          </TabsTrigger>
          <TabsTrigger 
            value="image" 
            className="rounded-none border-b-2 border-transparent data-[state=active]:border-purple-500 data-[state=active]:bg-transparent pb-3 px-0 text-zinc-500 data-[state=active]:text-zinc-100"
          >
            Image & Projection
          </TabsTrigger>
          <TabsTrigger 
            value="fluid" 
            className="rounded-none border-b-2 border-transparent data-[state=active]:border-purple-500 data-[state=active]:bg-transparent pb-3 px-0 text-zinc-500 data-[state=active]:text-zinc-100"
          >
            Fluid Dynamics
          </TabsTrigger>
        </TabsList>

        <div className="mt-8">
            <TabsContent value="destruction" className="space-y-6">
                <div className="grid md:grid-cols-2 gap-8">
                    <div className="space-y-4">
                        <h3 className="text-2xl font-semibold text-zinc-200">Real-time CSG</h3>
                        <p className="text-zinc-400 leading-7">
                            The solver uses optimized Constructive Solid Geometry (CSG) to carve meshes in real-time. Unlike standard methods, our solver pre-calculates fracture points to minimize server lag during explosions.
                        </p>
                        <ul className="space-y-2">
                            <li className="flex items-center gap-2 text-zinc-300 text-sm">
                                <Eraser className="w-4 h-4 text-purple-500" />
                                <span>Procedural debris generation</span>
                            </li>
                            <li className="flex items-center gap-2 text-zinc-300 text-sm">
                                <Layers className="w-4 h-4 text-purple-500" />
                                <span>Structural load-bearing calculation</span>
                            </li>
                        </ul>
                    </div>
                    <Card className="bg-zinc-950 border-zinc-800 flex items-center justify-center min-h-[200px]">
                        <div className="text-center space-y-2">
                            <Shapes className="w-12 h-12 text-zinc-800 mx-auto" />
                            <p className="text-xs text-zinc-600 font-mono">CSG VISUALIZER OFFLINE</p>
                        </div>
                    </Card>
                </div>
            </TabsContent>

            <TabsContent value="image" className="space-y-6">
                 <div className="flex items-start gap-6">
                    <div className="p-4 bg-zinc-900 rounded-xl border border-zinc-800 shrink-0">
                        <ImageIcon className="w-8 h-8 text-zinc-400" />
                    </div>
                    <div className="space-y-3">
                        <h3 className="text-xl font-semibold text-zinc-200">Dynamic Decals & Editing</h3>
                        <p className="text-zinc-400">
                            Allows for runtime editing of textures on geometry. This includes applying spray paints, bullet holes that wrap around curved surfaces, and projecting images onto complex UV maps without external tools.
                        </p>
                    </div>
                 </div>
            </TabsContent>

            <TabsContent value="fluid" className="space-y-6">
                 <div className="flex items-start gap-6">
                    <div className="p-4 bg-zinc-900 rounded-xl border border-zinc-800 shrink-0">
                        <Droplets className="w-8 h-8 text-blue-400" />
                    </div>
                    <div className="space-y-3">
                        <h3 className="text-xl font-semibold text-zinc-200">Particle-Based Fluids</h3>
                        <p className="text-zinc-400">
                            Simulates fluid viscosity and surface tension. The Geometry Solver calculates container volume and displaces fluid particles accordingly when objects enter the liquid.
                        </p>
                    </div>
                 </div>
            </TabsContent>
        </div>
      </Tabs>
    </div>
  );
}