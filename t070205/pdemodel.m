function pdemodel
[pde_fig,ax]=pdeinit;
pdetool('appl_cb',1);
set(ax,'DataAspectRatio',[1 1.5 1]);
set(ax,'PlotBoxAspectRatio',[1 0.66666666666666663 1]);
set(ax,'XLim',[0 1]);
set(ax,'YLim',[0 1]);
set(ax,'XTickMode','auto');
set(ax,'YTickMode','auto');
pdetool('gridon','on');

% Geometry description:
pderect([0 0.10000000000000001 0.90000000000000002 0],'R1');
pderect([0.10000000000000001 0.20000000000000001 0.5 0],'R2');
pderect([0.20000000000000001 0.30000000000000004 0.90000000000000002 0],'R3');
pderect([0.29999999999999999 0.40000000000000002 0.5 0],'R4');
pderect([0.40000000000000002 0.90000000000000002 0.90000000000000002 0],'R5');
pderect([0.90000000000000002 1 0.5 0],'R6');
set(findobj(get(pde_fig,'Children'),'Tag','PDEEval'),'String','R1+R2+R3+R4+R5+R6')

% PDE coefficients:
pdeseteq(1,...
'1.0',...
'0.0',...
'10.0',...
'1.0',...
'0:10',...
'0.0',...
'0.0',...
'[0 100]')
setappdata(pde_fig,'currparam',...
['1.0 ';...
'0.0 ';...
'10.0';...
'1.0 '])

% Solve parameters:
setappdata(pde_fig,'solveparam',...
char('0','1000','10','pdeadworst',...
'0.5','longest','0','1E-4','','fixed','Inf'))

% Plotflags and user data strings:
setappdata(pde_fig,'plotflags',[1 1 1 1 1 1 1 1 0 0 0 1 1 0 0 0 0 1]);
setappdata(pde_fig,'colstring','');
setappdata(pde_fig,'arrowstring','');
setappdata(pde_fig,'deformstring','');
setappdata(pde_fig,'heightstring','');
