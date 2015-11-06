function FileLoad = ChangeLengthOfMatrix(FileLoad, FR, LR, FC, LC, CR)
%MATRIX = ChangeLengthOfMatrix(MATRIX,FR,LR,FC,LC,CR);
%remove how many rows and columns you want from begining and end of matrix
%and copies first row to last position to make closed poligon
%0 - do nothing, N-nuber of rows/columns to change
%FR-remove number of rows from begining
%LR-remove number of last rows from end
%FC-remove number of columns from begining
%LC - remove number of columns from end

%CR - copy first row to last position

if FR~=0 
%Remove first row 
FileLoad = FileLoad(FR+1:end,:);
end
if LR~=0
%Remove last row 
%FileLoad(end,:) = [];
FileLoad = FileLoad(1:end-LR+1,:);
end
if FC~=0
%Remove first column 
%FileLoad(:,1) = [];
FileLoad = FileLoad(:,FC+1:end);
end
if LC~=0
%Remove last LC columns
FileLoad = FileLoad(:,1:end-LC);
end

if CR~=0
%Copy First row to last 
NumberOfRowsInFileLoad = size(FileLoad,1);
NumberOfColumnsInFileLoad = size(FileLoad,2);
FileLoad = [FileLoad(1:NumberOfRowsInFileLoad,:); FileLoad(1,:); FileLoad(NumberOfRowsInFileLoad+1:end,:)];
end