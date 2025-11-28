import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { createPageUrl } from './utils';
import { 
  LayoutDashboard, 
  Atom, 
  Music, 
  Shapes, 
  Database, 
  Menu,
  X,
  Github,
  Twitter
} from 'lucide-react';
import { Button } from "@/components/ui/button";
import { motion, AnimatePresence } from "framer-motion";

export default function Layout({ children }) {
  const location = useLocation();
  const [isMobileMenuOpen, setIsMobileMenuOpen] = React.useState(false);

  const navItems = [
    { name: 'Home', icon: LayoutDashboard, path: 'Home' },
    { name: 'Physics', icon: Atom, path: 'Physics' },
    { name: 'Sound', icon: Music, path: 'Sound' },
    { name: 'Geometry', icon: Shapes, path: 'Geometry' },
    { name: 'Data I/O', icon: Database, path: 'Data' },
  ];

  const isActive = (path) => {
    // Handle simplified path matching
    const currentPath = location.pathname.replace('/', '');
    return currentPath === path || (currentPath === '' && path === 'Home');
  };

  return (
    <div className="min-h-screen bg-zinc-950 text-zinc-300 font-sans selection:bg-zinc-700 selection:text-white">
      {/* Top Navigation Bar */}
      <nav className="fixed top-0 left-0 right-0 z-50 border-b border-zinc-800 bg-zinc-950/80 backdrop-blur-md">
        <div className="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="relative w-14 h-14 flex items-center justify-center group">
              <svg viewBox="0 0 100 100" className="w-full h-full text-zinc-100" fill="none" stroke="currentColor" strokeWidth="2">
                 {/* 3D Wireframe Cube */}
                 <path d="M20 20 L80 20 L80 80 L20 80 Z" className="opacity-90" />
                 <path d="M30 10 L90 10 L90 70 L30 70 Z" className="opacity-40" />
                 <path d="M20 20 L30 10 M80 20 L90 10 M80 80 L90 70 M20 80 L30 70" className="opacity-40" />
                 
                 {/* Corner Vertices (Balls) */}
                 <circle cx="20" cy="20" r="3" fill="currentColor" />
                 <circle cx="80" cy="20" r="3" fill="currentColor" />
                 <circle cx="80" cy="80" r="3" fill="currentColor" />
                 <circle cx="20" cy="80" r="3" fill="currentColor" />
                 <circle cx="30" cy="10" r="3" fill="currentColor" className="opacity-50" />
                 <circle cx="90" cy="10" r="3" fill="currentColor" className="opacity-50" />
                 <circle cx="90" cy="70" r="3" fill="currentColor" className="opacity-50" />
                 <circle cx="30" cy="70" r="3" fill="currentColor" className="opacity-50" />
              </svg>
              {/* Center Text */}
              <div className="absolute inset-0 flex items-center justify-center">
                  <span className="text-[10px] font-bold bg-zinc-950 text-zinc-100 px-1 border border-zinc-800 rounded font-mono tracking-tighter">sPhys</span>
              </div>
            </div>
            <span className="font-bold text-zinc-100 tracking-tight text-lg -ml-1">sPhysics</span>
          </div>

          {/* Desktop Menu */}
          <div className="hidden md:flex items-center gap-1">
            {navItems.map((item) => (
              <Link key={item.name} to={createPageUrl(item.path)}>
                <Button
                  variant="ghost"
                  className={`
                    flex items-center gap-2 px-4 h-9 rounded-md transition-all duration-200
                    ${isActive(item.path) 
                      ? 'bg-zinc-800 text-zinc-50 font-medium' 
                      : 'text-zinc-400 hover:text-zinc-100 hover:bg-zinc-900'}
                  `}
                >
                  <item.icon className="w-4 h-4" />
                  {item.name}
                </Button>
              </Link>
            ))}
          </div>

          <div className="hidden md:flex items-center gap-4">
             <div className="h-4 w-px bg-zinc-800" />
             <div className="flex gap-2">
               <a href="https://github.com/Sandwichmaster28/sPhysics" target="_blank" rel="noopener noreferrer">
                 <Button variant="ghost" size="icon" className="h-8 w-8 text-zinc-500 hover:text-zinc-100">
                   <Github className="w-4 h-4" />
                 </Button>
               </a>
             </div>
          </div>

          {/* Mobile Toggle */}
          <div className="md:hidden">
            <Button 
              variant="ghost" 
              size="icon"
              onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
              className="text-zinc-100"
            >
              {isMobileMenuOpen ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
            </Button>
          </div>
        </div>
      </nav>

      {/* Mobile Menu Overlay */}
      <AnimatePresence>
        {isMobileMenuOpen && (
          <motion.div
            initial={{ opacity: 0, y: -20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -20 }}
            className="fixed inset-0 z-40 pt-20 px-6 bg-zinc-950 md:hidden"
          >
            <div className="flex flex-col gap-2">
              {navItems.map((item) => (
                <Link 
                  key={item.name} 
                  to={createPageUrl(item.path)}
                  onClick={() => setIsMobileMenuOpen(false)}
                >
                  <Button
                    variant="ghost"
                    className={`
                      w-full justify-start gap-3 h-12 text-lg
                      ${isActive(item.path) 
                        ? 'bg-zinc-800 text-zinc-50' 
                        : 'text-zinc-400 hover:text-zinc-100 hover:bg-zinc-900'}
                    `}
                  >
                    <item.icon className="w-5 h-5" />
                    {item.name}
                  </Button>
                </Link>
              ))}
            </div>
          </motion.div>
        )}
      </AnimatePresence>

      {/* Main Content */}
      <main className="pt-24 pb-20 px-6 max-w-7xl mx-auto">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.4 }}
        >
          {children}
        </motion.div>
      </main>

      {/* Footer */}
      <footer className="border-t border-zinc-900 mt-auto py-12 bg-zinc-950">
        <div className="max-w-7xl mx-auto px-6 flex flex-col md:flex-row justify-between items-center gap-6 text-zinc-500 text-sm">
          <p>© 2023 sPhysics. All rights reserved.</p>
          <div className="flex gap-6">
            <span className="hover:text-zinc-300 cursor-pointer">Documentation</span>
            <span className="hover:text-zinc-300 cursor-pointer">API Reference</span>
            <span className="hover:text-zinc-300 cursor-pointer">Status</span>
          </div>
        </div>
      </footer>
    </div>
  );
}