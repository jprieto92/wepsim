/*
 *  Copyright 2015-2018 Felix Garcia Carballeira, Alejandro Calderon Mateos, Javier Prieto Cepeda, Saul Alonso Monsalve
 *
 *  This file is part of WepSIM.
 *
 *  WepSIM is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  WepSIM is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with WepSIM.  If not, see <http://www.gnu.org/licenses/>.
 *
 */


/*
 * cache versioning
 */

var cacheName = 'v191b:static';


/*
 * install
 */

self.addEventListener('install', 
	              function(e) {
			    e.waitUntil(
				caches.open(cacheName).then(function(cache) {
				    return cache.addAll([
                                        './min.wepsim_pwa.js',
                                        './sim_hw/sim_hw_ep/controlunit6.svg',
                                        './sim_hw/sim_hw_ep/processor6.svg',
                                        './sim_hw/sim_hw_ep/cpu6.svg',
                                        './images/ajax-loader.gif',
                                        './images/reset.svg',
                                        './images/author_salonso.png',
                                        './images/monitor2.png',
                                        './images/author_jprieto.png',
                                        './images/author_acaldero.png',
                                        './images/cfg-rf.gif',
                                        './images/keyboard1.png',
                                        './images/cfg-colors.gif',
                                        './images/fire.gif',
                                        './images/author_fgarcia.png',
                                        './images/arcos.svg',
					'./images/stop_classic.gif',
					'./images/stop_simple.gif',
					'./images/stop_pushpin.gif',
					'./images/stop_cat1.gif',
					'./images/stop_dog1.gif',
					'./images/stop_super.gif',
					'./images/stop_batman.gif',
					'./images/stop_hp1.gif',
					'./images/stop_hp2.gif',
					'./images/stop_lotr1.gif',
					'./images/stop_lotr2.gif',
					'./images/stop_lotr3.gif',
					'./images/stop_lotr4.gif',
					'./images/stop_bb8.gif',
					'./images/stop_r2d2.gif',
					'./images/stop_sw.gif',
					'./images/stop_vader1.gif',
					'./images/stop_grail.gif',
					'./images/stop_despicable.gif',
                                        './docs/manifest.json',
                                        './docs/gpl.txt',
                                        './docs/lgpl.txt',
                                        './examples/ep/exampleMicrocodeS1E1.txt',
                                        './examples/ep/exampleMicrocodeS1E2.txt',
                                        './examples/ep/exampleMicrocodeS1E3.txt',
                                        './examples/ep/exampleMicrocodeS1E4.txt',
                                        './examples/ep/exampleMicrocodeS2E1.txt',
                                        './examples/ep/exampleMicrocodeS2E2.txt',
                                        './examples/ep/exampleMicrocodeS2E3.txt',
                                        './examples/ep/exampleMicrocodeS2E4.txt',
                                        './examples/ep/exampleMicrocodeS3E1.txt',
                                        './examples/ep/exampleMicrocodeS3E2.txt',
                                        './examples/ep/exampleMicrocodeS3E3.txt',
                                        './examples/ep/exampleMicrocodeS3E4.txt',
                                        './examples/ep/exampleMicrocodeMIPS.txt',
                                        './examples/ep/exampleCodeS1E1.txt',
                                        './examples/ep/exampleCodeS1E2.txt',
                                        './examples/ep/exampleCodeS1E3.txt',
                                        './examples/ep/exampleCodeS1E4.txt',
                                        './examples/ep/exampleCodeS2E1.txt',
                                        './examples/ep/exampleCodeS2E2.txt',
                                        './examples/ep/exampleCodeS2E3.txt',
                                        './examples/ep/exampleCodeS2E4.txt',
                                        './examples/ep/exampleCodeS3E1.txt',
                                        './examples/ep/exampleCodeS3E2.txt',
                                        './examples/ep/exampleCodeS3E3.txt',
                                        './examples/ep/exampleCodeS3E4.txt',
                                        './help/about-es.html',
                                        './help/about-en.html',
                                        './help/welcome/help_usage.gif',
                                        './help/welcome/menu_open.gif',
                                        './help/welcome/config_usage.gif',
                                        './help/welcome/simulation_xinstruction.gif',
                                        './help/welcome/example_usage.gif',
                                        './help/ep/signals-en.html',
                                        './help/ep/signals-es.html',
                                        './help/ep/signals/props002.xml',
                                        './help/ep/signals/image008.jpg',
                                        './help/ep/signals/image008.png',
                                        './help/ep/signals/image009.png',
                                        './help/ep/signals/colorschememapping.xml',
                                        './help/ep/signals/item0001.xml',
                                        './help/ep/signals/themedata.thmx',
                                        './help/ep/signals/image002.png',
                                        './help/ep/signals/image003.png',
                                        './help/ep/signals/image003.jpg',
                                        './help/ep/signals/image001.jpg',
                                        './help/ep/signals/image001.png',
                                        './help/ep/signals/image004.jpg',
                                        './help/ep/signals/image004.png',
                                        './help/ep/signals/image010.png',
                                        './help/ep/signals/image005.png',
                                        './help/ep/signals/image005.jpg',
                                        './help/ep/signals/image007.jpg',
                                        './help/ep/signals/filelist.xml',
                                        './help/ep/signals/image006.png',
                                        './help/ep/signals/image006.jpg',
                                        './help/ep/signals/header.html',
                                        './help/ep/ep-en.html',
                                        './help/ep/ep-es.html',
                                        './help/poc/signals-en.html',
                                        './help/poc/signals-es.html',
                                        './help/poc/signals/props002.xml',
                                        './help/poc/signals/image008.jpg',
                                        './help/poc/signals/image008.png',
                                        './help/poc/signals/image009.png',
                                        './help/poc/signals/colorschememapping.xml',
                                        './help/poc/signals/item0001.xml',
                                        './help/poc/signals/themedata.thmx',
                                        './help/poc/signals/image002.png',
                                        './help/poc/signals/image003.png',
                                        './help/poc/signals/image003.jpg',
                                        './help/poc/signals/image001.jpg',
                                        './help/poc/signals/image001.png',
                                        './help/poc/signals/image004.jpg',
                                        './help/poc/signals/image004.png',
                                        './help/poc/signals/image010.png',
                                        './help/poc/signals/image005.png',
                                        './help/poc/signals/image005.jpg',
                                        './help/poc/signals/image007.jpg',
                                        './help/poc/signals/filelist.xml',
                                        './help/poc/signals/image006.png',
                                        './help/poc/signals/image006.jpg',
                                        './help/poc/signals/header.html',
                                        './help/poc/poc-en.html',
                                        './help/simulator-en.html',
                                        './help/simulator-es.html',
                                        './help/simulator/simulator001.jpg',
                                        './help/simulator/simulator002.jpg',
                                        './help/simulator/simulator003.jpg',
                                        './help/simulator/simulator004.jpg',
                                        './help/simulator/simulator005.jpg',
                                        './help/simulator/simulator006.jpg',
                                        './help/simulator/simulator007.jpg',
                                        './help/simulator/simulator008.jpg',
                                        './help/simulator/simulator009.jpg',
                                        './help/simulator/simulator010.jpg',
                                        './help/simulator/simulator011.jpg',
                                        './help/simulator/simulator012.jpg',
                                        './help/simulator/simulator013.jpg',
                                        './help/simulator/simulator014.jpg',
                                        './help/simulator/simulator015.jpg',
                                        './help/simulator/simulator016.jpg',
                                        './help/simulator/simulator017.jpg',
                                        './help/simulator/assembly001.png',
                                        './help/simulator/assembly002.jpg',
                                        './help/simulator/assembly003.jpg',
                                        './help/simulator/assembly004.jpg',
                                        './help/simulator/assembly005.jpg',
                                        './help/simulator/firmware001.jpg',
                                        './help/simulator/firmware002.jpg',
                                        './help/simulator/firmware004.jpg',
                                        './help/simulator/firmware005.jpg',
                                        './external/jquery.mobile-1.4.5.min.css',
                                        './external/jquery.min.224.js',
                                        './external/jquery.mobile-1.4.5.min.js',
                                        './min.external.css',
                                        './min.external.js',
                                        './min.sim_all.js',
                                        './min.wepsim_web.js',
					'./index.html'
				    ]).then(function() {
					self.skipWaiting();
				    });
				})
			    );
});


 /*
  * fetch
  */

self.addEventListener('fetch', 
	              function(event) {
			    event.respondWith(fetch(event.request)) ;
                      });

