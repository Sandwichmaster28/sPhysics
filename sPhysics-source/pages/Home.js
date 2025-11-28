import React from 'react';
import { base44 } from '@/api/base44Client';
import { useQuery } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import { createPageUrl } from '../utils';
import {
  Atom,
  Music,
  Shapes,
  Database,
  ArrowRight,
  Activity,
  GitCommit,
  Terminal } from
'lucide-react';
import { Card, CardHeader, CardTitle, CardContent, CardFooter } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Skeleton } from "@/components/ui/skeleton";
import { format } from 'date-fns';

export default function Home() {
  const { data: updates, isLoading } = useQuery({
    queryKey: ['updates'],
    queryFn: () => base44.entities.Update.list({ sort: { date: -1 }, limit: 5 })
  });

  const features = [
  {
    title: "Parallel Physics",
    desc: "Real-time error correction for standard rigid body simulation.",
    icon: Atom,
    link: "Physics",
    color: "text-blue-400"
  },
  {
    title: "Sound Engine",
    desc: "Raycasted audio propagation with dual API support.",
    icon: Music,
    link: "Sound",
    color: "text-emerald-400"
  },
  {
    title: "Geometry Solver",
    desc: "Advanced fluid dynamics and destruction physics.",
    icon: Shapes,
    link: "Geometry",
    color: "text-purple-400"
  },
  {
    title: "Data I/O",
    desc: "Secure RemoteFunction handling and HTTP networking.",
    icon: Database,
    link: "Data",
    color: "text-orange-400"
  }];


  return (
    <div className="space-y-12">
      
      {/* Hero Section */}
      <div className="flex flex-col md:flex-row gap-8 items-center justify-between py-8">
        <div className="space-y-4 max-w-2xl">
          <div className="inline-flex items-center px-3 py-1 rounded-full bg-zinc-900 border border-zinc-800 text-xs font-medium text-zinc-400">
            <span className="w-2 h-2 rounded-full bg-green-500 mr-2 animate-pulse"></span>
            v2.1.0 Stable Build
          </div>
          <h1 className="text-5xl md:text-6xl font-bold text-zinc-50 tracking-tight">
            Next Gen <br />
            <span className="text-zinc-400">Roblox Engineering.</span>
          </h1>
          <p className="text-zinc-400 text-lg font-semibold leading-relaxed max-w-lg">Doing what DAVID "Doesn't wanna" do.

          </p>
          <div className="flex gap-4 pt-2">
            <Link to={createPageUrl('Physics')}>
              <Button className="bg-zinc-100 text-zinc-950 hover:bg-zinc-300 font-semibold h-12 px-6">
                Start Documentation
              </Button>
            </Link>
            <a href="https://github.com/Sandwichmaster28/sPhysics" target="_blank" rel="noopener noreferrer">
              <Button variant="outline" className="border-zinc-700 text-zinc-300 hover:bg-zinc-900 h-12 px-6">
                View Source
              </Button>
            </a>
          </div>
        </div>
        
        <div className="w-full md:w-1/3 h-64 bg-gradient-to-br from-zinc-900 to-zinc-950 rounded-2xl border border-zinc-800 flex items-center justify-center relative overflow-hidden group">
           <div className="absolute inset-0 opacity-20 bg-[radial-gradient(circle_at_center,_var(--tw-gradient-stops))] from-zinc-700 via-zinc-950 to-zinc-950"></div>
           <Terminal className="w-24 h-24 text-zinc-800 group-hover:text-zinc-700 transition-colors duration-500" />
        </div>
      </div>

      {/* Quick Links Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        {features.map((feature) =>
        <Link key={feature.title} to={createPageUrl(feature.link)}>
            <Card className="bg-zinc-900/50 border-zinc-800 hover:border-zinc-600 transition-all duration-300 h-full group">
              <CardContent className="p-6 flex flex-col gap-4">
                <div className="w-10 h-10 rounded-lg bg-zinc-950 border border-zinc-800 flex items-center justify-center group-hover:scale-110 transition-transform">
                  <feature.icon className={`w-5 h-5 ${feature.color}`} />
                </div>
                <div>
                  <h3 className="font-semibold text-zinc-100 mb-1">{feature.title}</h3>
                  <p className="text-sm text-zinc-500 leading-snug">{feature.desc}</p>
                </div>
              </CardContent>
            </Card>
          </Link>
        )}
      </div>

      {/* Updates Section */}
      <div className="grid md:grid-cols-3 gap-8">
        <div className="md:col-span-2 space-y-6">
          <div className="flex items-center justify-between">
             <h2 className="text-2xl font-bold text-zinc-100 flex items-center gap-2">
               <Activity className="w-5 h-5 text-zinc-500" />
               Current Updates
             </h2>
             <Badge variant="outline" className="border-zinc-700 text-zinc-400">Changelog</Badge>
          </div>
          
          <div className="space-y-4">
            {isLoading ?
            Array(3).fill(0).map((_, i) =>
            <div key={i} className="h-24 bg-zinc-900/50 rounded-lg animate-pulse" />
            ) :
            updates?.map((update) =>
            <Card key={update.id} className="bg-zinc-950 border-zinc-800 hover:bg-zinc-900/30 transition-colors">
                <CardContent className="p-5">
                  <div className="flex items-start justify-between mb-2">
                    <div className="flex items-center gap-3">
                      <Badge className={`
                        ${update.type === 'major' ? 'bg-zinc-100 text-zinc-950' :
                    update.type === 'minor' ? 'bg-zinc-800 text-zinc-300' : 'bg-zinc-900 text-zinc-500 border-zinc-800'}
                      `}>
                        {update.version}
                      </Badge>
                      <span className="text-zinc-500 text-sm font-mono">
                        {format(new Date(update.date), 'MMM dd, yyyy')}
                      </span>
                    </div>
                  </div>
                  <h3 className="text-lg font-medium text-zinc-200 mb-2">{update.title}</h3>
                  <p className="text-zinc-500 text-sm">{update.description}</p>
                </CardContent>
              </Card>
            )}
          </div>
        </div>

        <div className="space-y-6">
          <Card className="bg-zinc-900/20 border-zinc-800 h-full">
            <CardHeader>
              <CardTitle className="text-zinc-200 text-lg flex items-center gap-2">
                <GitCommit className="w-4 h-4" />
                System Status
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="space-y-2">
                <div className="flex justify-between text-sm">
                  <span className="text-zinc-400">Physics Engine</span>
                  <span className="text-green-400">Operational</span>
                </div>
                <div className="h-1 w-full bg-zinc-900 rounded-full overflow-hidden">
                  <div className="h-full bg-green-500/50 w-full" />
                </div>
              </div>
              <div className="space-y-2">
                <div className="flex justify-between text-sm">
                  <span className="text-zinc-400">Sound API</span>
                  <span className="text-green-400">Operational</span>
                </div>
                <div className="h-1 w-full bg-zinc-900 rounded-full overflow-hidden">
                  <div className="h-full bg-green-500/50 w-full" />
                </div>
              </div>
              <div className="space-y-2">
                <div className="flex justify-between text-sm">
                  <span className="text-zinc-400">Data Relay</span>
                  <span className="text-yellow-400">High Latency</span>
                </div>
                <div className="h-1 w-full bg-zinc-900 rounded-full overflow-hidden">
                  <div className="h-full bg-yellow-500/50 w-3/4" />
                </div>
              </div>
            </CardContent>
            <CardFooter>
               <Button className="w-full bg-zinc-800 hover:bg-zinc-700 text-zinc-200">View Full Report</Button>
            </CardFooter>
          </Card>
        </div>
      </div>
    </div>);

}