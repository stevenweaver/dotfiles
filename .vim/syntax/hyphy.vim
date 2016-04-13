" Vim syntax file
" Language:    HyPhy Batch Language
" Maintainer:  Steven Weaver <steven@stevenweaver.org>
" Last Change: 2016 Apr 13


" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
if version < 600
  so <sfile>:p:h/cpp.vim
else
  runtime! syntax/cpp.vim
endif

syn keyword hyphyBuiltin Abs Arctan Beta BranchCount BranchLength BranchName
syn keyword hyphyBuiltin CChi2 CGammaDist Columns Cos Eigensystem Erf Eval Exp
syn keyword hyphyBuiltin Format Gamma GammaDist IBeta IGamma InvChi2 Inverse
syn keyword hyphyBuiltin Join LnGamma Log LUDecompose LUSolve Max Min PSTreeString
syn keyword hyphyBuiltin Random RerootTree Rows Simplex Sin Sqrt Tan Time
syn keyword hyphyBuiltin TipCount TipName Transpose Type ZCDF

syn keyword HBLCommand AlignSequences Assert BGM 
syn keyword HBLCommand Category ChoiceList ClearConstraints
syn keyword HBLCommand ConstructCategoryMatrix CovarianceMatrix
syn keyword HBLCommand DataSet DataSetFilter DeleteObject Differentiate DoSQL
syn keyword HBLCommand ExecuteAFile ExecuteCommands Export Ffunction FindRoot
syn keyword HBLCommand fprintf fscanf function GetDataInfo GetInformation GetNeutralNull
syn keyword HBLCommand GetString GetURL HarvestFrequencies Import Integrate LFCompute
syn keyword HBLCommand LikelihoodFunction LikelihoodFunction3 LoadFunctionLibrary Model
syn keyword HBLCommand MolecularClock MPIReceive MPISend OpenDataPanel OpenWindow
syn keyword HBLCommand Optmize ReplicateConstraint RequireVersion SCFG 
syn keyword HBLCommand SelectTemplateModel SetDialogPrompt SetParameter SimulateDataSet
syn keyword HBLCommand SpawnLikelihoodFunction StateCounter UseModel

syn match hyphyFunction 
      \ "\%(\%(function\s\|function\s\|@\)\s*\)\@<=\h\%(\w\|>\)*" contained


hi def link hyphyBuiltin Statement
hi def link HBLCommand Statement
hi def link hyphyFunction Function

