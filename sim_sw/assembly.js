/*
 *  Copyright 2015-2023 Saul Alonso Monsalve, Javier Prieto Cepeda, Felix Garcia Carballeira, Alejandro Calderon Mateos
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
 *  Compile assembly
 */

function simlang_compile ( text, datosCU )
{
     var ret = null ;

//   ret = simlang_compile_v1(text, datosCU) ;  // Initial version

     // Testing...
     if (typeof ws_ng != "undefined") {
         ret = wsasm_src2mem(datosCU, text) ;
     }

     ret = simlang_compile_v2(text, datosCU) ;

//   ret = wsasm_src2mem(datosCU, text) ;  // TESTING

     return ret ;
}

