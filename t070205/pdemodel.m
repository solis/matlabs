function pdemodel
[pde_fig,ax]=pdeinit;
pdetool('appl_cb',1);
set(ax,'DataAspectRatio',[1 1.5 1]);
set(ax,'PlotBoxAspectRatio',[1 0.66666666666666663 2]);
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

% Boundary conditions:
pdetool('changemode',0)
pdesetbd(24,...
'neu',...
1,...
'0',...
'(-20 .* (-1+y) .* sin(20 .* (-1+x) .* (-1+y)))')
pdesetbd(22,...
'dir',...
1,...
'1',...
'cos(20.*(x-1).*(y-1))')
pdesetbd(21,...
'dir',...
1,...
'1',...
'cos(20.*(x-1).*(y-1))')
pdesetbd(20,...
'dir',...
1,...
'1',...
'cos(20.*(x-1).*(y-1))')
pdesetbd(19,...
'dir',...
1,...
'1',...
'cos(20.*(x-1).*(y-1))')
pdesetbd(18,...
'dir',...
1,...
'1',...
'cos(20.*(x-1).*(y-1))')
pdesetbd(17,...
'dir',...
1,...
'1',...
'cos(20.*(x-1).*(y-1))')
pdesetbd(16,...
'neu',...
1,...
'0',...
'(-20 .* (-1+y) .* sin(20 .* (-1+x) .* (-1+y)))')
pdesetbd(15,...
'dir',...
1,...
'1',...
'cos(20.*(x-1).*(y-1))')
pdesetbd(14,...
'dir',...
1,...
'1',...
'cos(20.*(x-1).*(y-1))')
pdesetbd(13,...
'neu',...
1,...
'0',...
'(-20 .* (-1+y) .* sin(20 .* (-1+x) .* (-1+y)))')
pdesetbd(11,...
'dir',...
1,...
'1',...
'cos(20.*(x-1).*(y-1))')
pdesetbd(10,...
'dir',...
1,...
'1',...
'cos(20.*(x-1).*(y-1))')
pdesetbd(9,...
'dir',...
1,...
'1',...
'cos(20.*(x-1).*(y-1))')
pdesetbd(8,...
'neu',...
1,...
'0',...
'(-20 .* (-1+y) .* sin(20 .* (-1+x) .* (-1+y)))')
pdesetbd(6,...
'neu',...
1,...
'0',...
'(-20 .* (-1+y) .* sin(20 .* (-1+x) .* (-1+y)))')
pdesetbd(4,...
'neu',...
1,...
'0',...
'(-20 .* (-1+y) .* sin(20 .* (-1+x) .* (-1+y)))')
pdesetbd(2,...
'neu',...
1,...
'0',...
'(-20 .* (-1+y) .* sin(20 .* (-1+x) .* (-1+y)))')
pdesetbd(1,...
'neu',...
1,...
'0',...
'(-20 .* (-1+y) .* sin(20 .* (-1+x) .* (-1+y)))')

% Mesh generation:
setappdata(pde_fig,'Hgrad',1.3);
setappdata(pde_fig,'refinemethod','regular');
setappdata(pde_fig,'jiggle',char('on','mean',''));
pdetool('initmesh')
pdetool('refine')
pdetool('refine')

% PDE coefficients:
pdeseteq(1,...
'1.0',...
'0.0',...
'(-400) .* (cos(20 .* (y - 1) .* (x -1))) .* ((1-x).^2 + (1 - y).^2)',...
'1.0',...
'0:10',...
'0.0',...
'0.0',...
'[0 100]')
setappdata(pde_fig,'currparam',...
['1.0                                                                ';...
'0.0                                                                ';...
'(-400) .* (cos(20 .* (y - 1) .* (x -1))) .* ((1-x).^2 + (1 - y).^2)';...
'1.0                                                                '])

% Solve parameters:
setappdata(pde_fig,'solveparam',...
char('0','7536','10','pdeadworst',...
'0.5','longest','0','1E-4','','fixed','Inf'))

% Plotflags and user data strings:
setappdata(pde_fig,'plotflags',[1 1 1 1 1 1 8 1 0 0 0 1 1 0 1 0 0 1]);
setappdata(pde_fig,'colstring','');
setappdata(pde_fig,'arrowstring','');
setappdata(pde_fig,'deformstring','');
setappdata(pde_fig,'heightstring','');

% Solve PDE:
pdetool('solve')
