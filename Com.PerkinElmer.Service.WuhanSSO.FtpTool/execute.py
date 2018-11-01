from Spotfire.Dxp.Data.Export import DataWriterTypeIdentifiers 
from System.IO import File
from System.Diagnostics import Process

table = Document.ActiveDataTableReference
writer = Document.Data.CreateDataWriter(DataWriterTypeIdentifiers.SbdfDataWriter)

filtering = Document.ActiveFilteringSelectionReference.GetSelection(table).AsIndexSet()

stream = File.OpenWrite("D:\\SSOTEMP\\" + SessionID)

names = []
for col in table.Columns:
  names.append(col.Name)

writer.Write(stream, table, filtering, names)

stream.Close()

p = Process()
p.StartInfo.FileName = ToolPath
p.StartInfo.UseShellExecute = False
p.StartInfo.RedirectStandardInput = True
p.StartInfo.RedirectStandardOutput = True
p.StartInfo.RedirectStandardError = True
p.StartInfo.CreateNoWindow = True
p.StartInfo.Arguments = SessionID
p.Start()
