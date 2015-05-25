function [connection] = tfaceLoadConnectivity(filename);

fid = fopen(filename);
line = fgets(fid);

connVec = -1;
    
while line~=-1
    [name, rest] = strtok(line);
       
    if (size(name, 2)>7)
        if (strcmp(name(1:7), 'indices'))
            ptList = name(9:size(name, 2)-1);
            [pt, ptRest] = strtok(ptList, ',');
            
            connVec = sscanf(pt, '%i');
                
            while (size(ptRest, 2)~=0)
                [pt, ptRest] = strtok(ptRest, ',');
                connVec(size(connVec, 2)+1) = sscanf(pt, '%i');
            end
        end
    end

    closed = 0;
    if (strcmp(name, 'form'))
        if (rest(2) == 'c') % closed boundary
            % closed = 1;
            % connect the points here
            connVec(size(connVec, 2)+1) = connVec(1);
        end
        
        for i = 1:size(connVec, 2)-1
            connection(connVec(i)+1, connVec(i+1)+1) = 1;
            connection(connVec(i+1)+1, connVec(i)+1) = 1;
        end
    end
    
    line = fgets(fid);
end

