/*
 *  Copyright 2015-2024 Felix Garcia Carballeira, Alejandro Calderon Mateos, Javier Prieto Cepeda, Saul Alonso Monsalve
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
         *  Main Memory
         */

        /* jshint esversion: 6 */
        class ws_bin_asm extends ws_uielto
        {
              // constructor
	      constructor ()
	      {
		    // parent
		    super();
	      }

              // render
              render ( event_name )
              {
                    // initialize render elements...
                    super.render() ;

                    // render current element
                    this.render_skel() ;
                    this.render_populate() ;
              }

              // render
	      render_skel ( )
	      {
		    // html holder
		    var o1 = "   <div id='compile_bin2a' " +
                             "        class='p-3' " +
                             "        style='width:100%; height: inherit !important;'> " +
                             "        <div class='d-flex align-items-center'> " +
                             "        Loading binary, please wait... <br/> " +
                             "        WARNING: loading binary might take time on slow devices. " +
                             "        </div> " +
                             "   </div> " ;

		    this.innerHTML = o1 ;
	      }

              render_populate ( )
              {
		    // check simware
                    var simware = get_simware() ;
		    if (null == simware) {
		        return ;
		    }

		    // get html code
		    var o = mp2html(simware.mp, simware.labels_asm, simware.seg) ;

                    o += '<span>Memory as binary section... </span>' +
                         '<span class="btn btn-sm" type="button" data-bs-toggle="collapse" ' +
                         '      data-bs-target="#mp2bin1" ' +
                         '      arial-expanded="true" arial-controls="memory as binary segment">+/-</span>' +
                         '<div id="mp2bin1" valign="top" colspan="2" align="center" class="m-2 p-2 collapse">' +
                         '<pre align="left">' +
		         mp2bin(simware.mp, simware.labels_asm, simware.seg) +
                         '</pre>' +
                         '</div>' ;

		    // set html code
		    $('#compile_bin2a').html(o) ;

                    // update limits
		    for (var skey in simware.seg) {
		         $("#compile_begin_" + skey).html("0x" + simware.seg[skey].begin.toString(16));
		         $("#compile_end_"   + skey).html("0x" + simware.seg[skey].end.toString(16));
		    }
	      }
        }

        register_uielto('ws-bin_asm', ws_bin_asm) ;


        /*
         *  obj2html
         */

	function labels_asmhtml_aux ( slebal, c )
	{
	     var clabel = "" ;
	     var wadd   = "" ;

             for (var j=3; j>=0; j--)
             {
	          wadd = "0x" + (parseInt(c)+j).toString(16);
	          if (typeof slebal[wadd] != "undefined")
                  {
                       for (var i=0; i<slebal[wadd].length; i++) {
		            clabel = clabel + "<span class='badge rounded-pill text-bg-secondary float-end'>" + slebal[wadd][i] + "</span>" ;
                       }
                  }
	          else clabel = clabel + "&nbsp;" ;
             }

	     return clabel ;
	}

	function mp2html ( mp, labels, seg )
	{
                // auxiliar for search label
                var slebal = {} ;
                for (var l in labels)
                {
                     if (typeof slebal[labels[l]] == "undefined") {
                         slebal[labels[l]] = [] ;
                     }
                     slebal[labels[l]].push(l);
                }

                // auxiliar for segments
                var slimits = {} ;
	        for (var skey1 in seg)
	        {
                     slimits[skey1] = {
                                        'c_begin': parseInt(seg[skey1].begin),
                                        'c_end':   parseInt(seg[skey1].end),
                                        'm_begin': parseInt(seg[skey1].begin),
                                        'm_end':   0,
                                        'loaded':  seg[skey1].loaded,
		                        'color':   seg[skey1].color
				      } ;

                     // try to use the limits loaded in main memory (if any) ...
                     if (slimits[skey1].loaded)
                          slimits[skey1].m_end = slimits[skey1].c_end ;
                     else slimits[skey1].m_end = slimits[skey1].c_begin + WORD_BYTES ;
                }

                // output...
		var o  = "";
		    o += "<center>" +
		 	 "<table class='border-0' style='table-layout:auto; border-style: solid; border-width:0px;'>" +
			 "<tr>" +
			 "<th class='border border-0'>labels</th>" +
			 "<th class='border border-1'>address</th>" +
			 "<th class='border border-1'>" +
                         "<table border=0 width=100%>" +
                       //"<tr><td colspan=8 align=center>content </td></tr>" +
                         "<tr align=center>" +
                         "  <td width='25%' align='center'><small><b>byte 3</b></small></td>" +
                         "  <td width='25%' align='center'><small><b>byte 2</b></small></td>" +
                         "  <td width='25%' align='center'><small><b>byte 1</b></small></td>" +
                         "  <td width='25%' align='center'><small><b>byte 0</b></small></td>" +
                         "</tr>" +
                         "<tr>" +
                         "  <td width='12%' align='center' >&nbsp;<sup>31&nbsp;&nbsp;......&nbsp;&nbsp;24</sup>&nbsp;</td>" +
                         "  <td width='12%' align='center' >&nbsp;<sup>23&nbsp;&nbsp;......&nbsp;&nbsp;16</sup>&nbsp;</td>" +
                         "  <td width='12%' align='center' >&nbsp;<sup>15&nbsp;&nbsp;......&nbsp;&nbsp;8</sup>&nbsp;</td>" +
                         "  <td width='12%' align='center' >&nbsp;<sup>7&nbsp;&nbsp;......&nbsp;&nbsp;0</sup>&nbsp;</td>" +
                         "</tr>" +
                         "</table>" +
			 "<th class='border border-0' align='right'>&nbsp;&nbsp;segment</th>" +
			 "</tr>" ;

	   	var color = "white" ;
	   	var sname = "" ;
	        for (var skey in seg)
	        {
                     // tip: ".binary" is a segment section but not a memory segment,
                     //      ".stack"  is a memory segment but not a segment section
	   	     sname = seg[skey].name ;
                     if (".binary" == skey)
                     {
                          if (false == slimits[skey].loaded)
	   	               continue ;   // skip empty ".binary" segment section
                          else sname = "" ; // skip ".binary" segment as memory segment name
                     }

                     c_begin =  slimits[skey].m_begin ;
                     c_end   =  slimits[skey].m_end ;
		     color   =  slimits[skey].color ;

                     rows    =  0 ;
                     var x   =  "" ;
                     var p   =  "" ;
                     var v   =  0 ;

		     for (var i=c_begin; i<=c_end; i++)
		     {
                             c = "0x" + i.toString(16) ;
                             if (typeof mp[c] == "undefined") {
                                 continue;
                             }

                             v = get_value(mp[c]) ;

			     p = "<tr class=\"font-monospace fs-6 text-dark\">" +
                                 "<td class='border border-0' align='right'>" + labels_asmhtml_aux(slebal,c) + "</td>" +
			         "<td        style='border-style: solid; border-width:1px;' bgcolor=" + color + ">" + c.toUpperCase() + "</td>" +
			         "<td        style='border-style: solid; border-width:1px;' bgcolor=" + color + ">" +
			          v.substr(0,8)  + "&nbsp;" + v.substr(8,8)  + "&nbsp;" + v.substr(16,8) + "&nbsp;" + v.substr(24,8) + "</td>" ;

                             if (0 == rows) {
			         o += p + "<td rowspan=" ;
                             } else {
			         x += p + "</tr>" ;
                             }

                             rows++;
	             }

		     p = "<tr class=\"font-monospace fs-6 text-dark\">" +
                         "<td>&nbsp;</td>" +
			 "<td style='border-style: solid; border-width:1px;' bgcolor=" + color + ">0x" + parseInt(seg[skey].begin).toString(16).toUpperCase() + "</td>" +
			 "<td style='border-style: solid; border-width:1px;' bgcolor=" + color + ">&nbsp;</td>" ;

		     if (0 == rows) {
			 o += p + "<td rowspan=" ;
			 x += p + "<td>&nbsp;</td>" + "</tr>" ;
                         rows = 2 ;
		     }

                     o += rows + " class=\"text-dark\" bgcolor=\"" + color + "\" align=right>" + sname + "&nbsp;</td></tr>" + x ;

	             if (seg[skey].name != ".stack") {
		         o += "<tr class=\"font-monospace fs-6 text-dark\">" +
                              "<td>&nbsp;</td>" +
                              "<td valign='middle' align='center' height='25px'>...</td>" +
                              "<td valign='middle' align='center' height='25px'>...</td>" +
                              "<td>&nbsp;</td>" +
                              "</tr>" ;
	             }
	        }

		o += "</table>" +
		     "</center><br>" ;

		return o;
	}

	function mp2bin ( mp, labels, seg )
	{
                // auxiliar for search
                var slebal = {} ;
                for (var l in labels)
                {
                     if (typeof slebal[labels[l]] == "undefined") {
                         slebal[labels[l]] = [] ;
                     }
                     slebal[labels[l]].push(l);
                }

                // output...
		var o = '\n.binary\n' ;
	        for (var a in mp)
	        {
		     // show labels
                     if (typeof slebal[a] != "undefined")
                     {
                         o += "  " ;
		         for (let j=0; j<slebal[a].length; j++) {
			      o += slebal[a][j] + ":\n" ;
		         }
                     }

		     // show address and value
                     o += "\t" ;
		     o += "0x" +          parseInt(a, 16).toString(16).padStart(2*WORD_BYTES, '0') + "\t" ;
		     o += "0x" + parseInt(mp[a].value, 2).toString(16).padStart(2*WORD_BYTES, '0') + "\n" ;
                }

		// return memory as binary segment
		return o ;
	}


