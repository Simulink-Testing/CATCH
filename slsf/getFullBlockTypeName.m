% 该方法可以获得到block的完整位置，用于生成新的块
function type = getFullBlockTypeName(type)
load_system('simulink');
% 获取所有块
Continuous_blocks = find_system('simulink/Continuous');
%
Discontinuities_blocks = find_system('simulink/Discontinuities');
%
Discrete_blocks = find_system('simulink/Discrete');
%
Math_Operations_blocks = find_system('simulink/Math Operations');
%
Ports_Subsystems_blocks = find_system('simulink/Ports & Subsystems');
%
Sources_blocks = find_system('simulink/Sources');
%
Sinks_blocks = find_system('simulink/Sinks');
%
Logic_blocks = find_system('simulink/Logic and Bit Operations');
%
Quick_Insert_blocks = find_system('simulink/Quick Insert/Sources');
%
User_Defined_Functions_blocks = find_system('simulink/User-Defined Functions');
%
Commonly_Used_Blocks = find_system('simulink/Commonly Used Blocks');
%
Quick_Insert_port_blocks = find_system('simulink/Quick Insert/Ports & Subsystems');
%
Signal_Routing_blocks = find_system('simulink/Signal Routing');
%
Signal_Attributes_blocks = find_system('simulink/Signal Attributes');
%
Model_Verification_blocks = find_system('simulink/Model Verification');



% 对Type进行处理
rs = isstrprop(type,'upper');
tag = 0;
for rd = 1:length(rs)
    if rs(rd) == 1 && rd~=1
        type = char(type);
        type = strcat(type(1:rd-1+tag)," ",type(rd+tag:end));
        tag = tag+1;
    end
end
if strcmp(type,'Abs')
    type = 'simulink/Math Operations/Abs';
    return;
end
if strcmp(type,'Magnitude Angle To Complex')
    type = 'simulink/Math Operations/Magnitude-Angle To Complex';
    return;
end
if strcmp(type,'Zero Pole')
    type = 'simulink/Continuous/Zero-Pole';
    return;
end
if strcmp(type,'Second Order Integratorx')
    type = 'simulink/Continuous/Second-Order Integratorx';
    return;
end
if strcmp(type,'Saturate')
    type = 'simulink/Commonly Used Blocks/Saturation';
    return;
end
if strcmp(type,'Complex To Real Imag')
    type = 'simulink/Math Operations/Complex to Real-Imag';
    return;
end
if strcmp(type,'Polyval')
    type = 'simulink/Math Operations/Polynomial';
    return;
end
if strcmp(type,'Discrete Fir')
    type = 'simulink/Discrete/Discrete FIR Filter';
    return;
end
if strcmp(type,'Relational Operator')
    type = 'simulink/Commonly Used Blocks/Relational Operator';
    return;
end
if strcmp(type,'Trigonometry')
    type = 'simulink/Math Operations/Trigonometric Function';
    return;
end
if strcmp(type,'Bus Creator')
    type = 'simulink/Commonly Used Blocks/Bus Creator';
    return;
end
if strcmp(type,'Signum')
    type = 'simulink/Math Operations/Sign';
    return;
end
if strcmp(type,'Scope')
    type = 'simulink/Commonly Used Blocks/Scope';
    return;
end
if strcmp(type,'Permute Dimensions')
    type = 'simulink/Math Operations/Permute Dimensions';
    return;
end
if strcmp(type,'Min Max')
    type = 'simulink/Math Operations/MinMax';
    return;
end
if strcmp(type,'Complex To Magnitude Angle')
    type = 'simulink/Math Operations/Complex to Magnitude-Angle';
    return;
end
if strcmp(type,'S- Function')
    type = 'simulink/User-Defined Functions/S-Function';
    return;
end
if strcmp(type,'Discrete State Space')
    type = 'simulink/Discrete/Discrete State-Space';
    return;
end
if strcmp(type,'Discrete Integrator')
    type = 'simulink/Discrete/Discrete-Time Integrator';
    return;
end
if strcmp(type,'Zero Order Hold')
    type = 'simulink/Discrete/Zero-Order Hold';
    return;
end
if strcmp(type,'Discrete Transfer Fcn')
    type = 'simulink/Discrete/Discrete Transfer Fcn';
    return;
end
if strcmp(type,'Discrete Zero Pole')
    type = 'simulink/Discrete/Discrete Zero-Pole';
    return;
end
if strcmp(type,'Lookup')
  type = 'simulink/Lookup Tables/n-D Lookup Table';
    return;
end
if strcmp(type,'Lookup N D Direct')
    type = 'simulink/Lookup Tables/n-D Lookup Table';
    return;
end
if strcmp(type,'Random Number')
    type = 'simulink/Sources/Random Number';
    return;
end
if strcmp(type,'Signal Generator')
    type = 'simulink/Sources/Signal Generator';
    return;
end
if strcmp(type,'Discrete Pulse Generator')
    type = 'simulink/Quick Insert/Sources/Discrete Pulse Generator';
    return;
end
if strcmp(type,'Assignment')
    type = 'simulink/Math Operations/Assignment';
    return;
end
if strcmp(type,'Uniform Random Number')
    type = 'simulink/Sources/Uniform Random Number';
    return;
end
if strcmp(type,'Spectrum Analyzer')
    type = 'DSP System Toolbox/Sinks/Spectrum Analyzer';
    return;
end

if strcmp(type,'Goto')
    type = 'simulink/Signal Routing/Goto';
    return;
end
if strcmp(type,'Relational Operator')
    type = 'simulink/Commonly Used Blocks/Relational Operator';
    return;
end
if strcmp(type,'Two Way Connection')
    type = 'simulink/Signal Routing/Two-Way Connection';
    return;
end
if strcmp(type,'From Workspace')
    type = 'simulink/Sources/From Workspace';
    return;
end
if strcmp(type,'Uniform Random Number')
    type = 'simulink/Sources/Uniform Random Number';
    return;
end
if strcmp(type,'Data Store Write')
    type = 'simulink/Signal Routing/Data Store Write';
    return;
end
if strcmp(type,'Real Imag To Complex')
    type = 'simulink/Math Operations/Real Imag to Complex';
    return;
end
if strcmp(type,'Second Order Integrator')
    type = 'simulink/Continuous/Second-Order Integrator';
    return;
end
if strcmp(type,'Rate Transition')
    type = 'simulink/Signal Attributes/Rate Transition';
    return;
end

if strcmp(type,'Data Type Duplicate')
    type = 'simulink/Signal Attributes/Data Type Duplicate';
    return;
end
if strcmp(type,'M A T L A B System')
    type = 'simulink/User-Defined Functions/MATLAB System';
    return;
end
if strcmp(type,'State Space')
    type = 'simulink/Discrete/Discrete State-Space';
    return;
end
if strcmp(type,'Bus Selector')
    type = 'simulink/Commonly Used Blocks/Bus Selector';
    return;
end
if strcmp(type,'If')
    type = 'simulink/Ports & Subsystems/If';
    return;
end
if strcmp(type,'Data Store Read')
    type = 'simulink/Signal Routing/Data Store Read';
    return;
end

if strcmp(type,'If Action Subsystem')
    type = 'simulink/Ports & Subsystems/If Action Subsystem';
    return;
end
TF = contains(Commonly_Used_Blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = Commonly_Used_Blocks(wo);
        type = result{1};
        return;
    end
end
TF = contains(Signal_Attributes_blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = Signal_Attributes_blocks(wo);
        type = result{1};
        return;
    end
end
TF = contains(Model_Verification_blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = Model_Verification_blocks(wo);
        type = result{1};
        return;
    end
end
TF = contains(Signal_Routing_blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = Signal_Routing_blocks(wo);
        type = result{1};
        return;
    end
end
TF = contains(Logic_blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = Logic_blocks(wo);
        type = result{1};
        return;
    end
end
TF = contains(Quick_Insert_port_blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = Quick_Insert_port_blocks(wo);
        type = result{1};
        return;
    end
end
TF = contains(Math_Operations_blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = Math_Operations_blocks(wo);
        type = result{1};
        return;
    end
end
TF = contains(Continuous_blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = Continuous_blocks(wo);
        type = result{1};
        return;
    end
end
TF = contains(User_Defined_Functions_blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = User_Defined_Functions_blocks(wo);
        type = result{1};
        return;
    end
end
TF = contains(Discontinuities_blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = Discontinuities_blocks(wo);
        type = result{1};
        return;
    end
end
TF = contains(Discrete_blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = Discrete_blocks(wo);
        type = result{1};
        return;
    end
end
TF = contains(Sources_blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = Sources_blocks(wo);
        type = result{1};
        return;
    end
end
TF = contains(Ports_Subsystems_blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = Ports_Subsystems_blocks(wo);
        type = result{1};
        return;
    end
end
TF = contains(Sinks_blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = Sinks_blocks(wo);
        type = result{1};
        return;
    end
end
TF = contains(Quick_Insert_blocks,type,'IgnoreCase',true);
for wo=1:length(TF)
    if TF(wo)~=0
        result = Quick_Insert_blocks(wo);
        type = result{1};
        return;
    end
end
end
