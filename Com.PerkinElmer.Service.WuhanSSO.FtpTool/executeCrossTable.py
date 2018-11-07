# parameters should be created
# crossTable, The CrossTablePlot Visualization
import clr
clr.AddReference("System.IO")
 
from Spotfire.Dxp.Application.Visuals import CrossTablePlot
from System.IO import TextWriter, File
 
ct = crossTable.As[CrossTablePlot]()

textWriter = File.CreateText("D:\\SSOTEMP\\" + SessionID)
ct.ExportText(textWriter)
textWriter.Close();

p = Process()
p.StartInfo.FileName = ToolPath
p.StartInfo.UseShellExecute = False
p.StartInfo.RedirectStandardInput = True
p.StartInfo.RedirectStandardOutput = True
p.StartInfo.RedirectStandardError = True
p.StartInfo.CreateNoWindow = True
p.StartInfo.Arguments = SessionID + " CROSSTABLE" + " txt"
p.Start()
