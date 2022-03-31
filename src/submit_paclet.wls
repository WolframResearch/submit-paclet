#!/usr/bin/env wolframscript
(* ::Package:: *)

(* :!CodeAnalysis::BeginBlock:: *)
(* :!CodeAnalysis::Disable::SuspiciousSessionSymbol:: *)

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
print[ a___ ] := WriteString[ "stdout", a, "\n" ];

print[ "Loading Wolfram`PacletCICD` from ", FindFile[ "Wolfram`PacletCICD`" ] ];

Needs[ "Wolfram`PacletCICD`" ];

getInput[ name_String ] :=
    Module[ { val },
        val = Environment[ "INPUT_" <> name ];
        print[ name, "=", val ];
        val
    ];

print[ "Submitting paclet..." ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Inputs*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Definition Notebook*)
defNB  = getInput[ "DEFINITION_NOTEBOOK" ];
If[ ! FileExistsQ @ ExpandFileName @ defNB,
    print[ "::error::Definition notebook not found: ", defNB ];
    Exit[ 1 ]
];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*ResourceSystemBase*)
rsBase     = getInput[ "RESOURCE_SYSTEM_BASE" ];
rsTestURL  = URLBuild @ { rsBase, "TestSystem" };
rsBaseTest = URLFetch[ rsTestURL, { "StatusCode", "Content" } ];
If[ ! MatchQ[ rsBaseTest, { 200, _String } ],
    print[ "::error::Invalid ResourceSystemBase: ", rsBase ];
    print[ "::error::ResourceSystemBase test output: ", rsBaseTest ];
    Exit[ 1 ]
];

Needs[ "ResourceSystemClient`" -> None ];
$ResourceSystemBase = rsBase;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Run*)
result =
    Block[
        {
            Print = print,
            DefinitionNotebookClient`BeginConsoleGroup,
            DefinitionNotebookClient`EndConsoleGroup
        },
        Wolfram`PacletCICD`SubmitPaclet[
            File @ defNB,
            "ConsoleType" -> "GitHub"
        ]
    ];

print @ result;

If[ MatchQ[ result, _Wolfram`PacletCICD`SubmitPaclet ],
    print[ "::error::Wolfram`PacletCICD`SubmitPaclet not defined" ];
    Exit[ 1 ]
];

(* :!CodeAnalysis::EndBlock:: *)