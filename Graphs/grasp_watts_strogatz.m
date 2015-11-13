%Constructs a graph from the Watts-Strogatz model.
%
%   graph = GRAPH_WATTS_STROGATZ(N, K, beta) constructs a watts-stogatz
%   graph with N nodes, average degree K and with probability beta of
%   rewiring.
%
% Authors:
%  - Benjamin Girault <benjamin.girault@ens-lyon.fr>

% Copyright Benjamin Girault, École Normale Supérieure de Lyon, FRANCE /
% Inria, FRANCE (2015-11-01)
% 
% benjamin.girault@ens-lyon.fr
% 
% This software is a computer program whose purpose is to provide a Matlab
% / Octave toolbox for handling and displaying graph signals.
% 
% This software is governed by the CeCILL license under French law and
% abiding by the rules of distribution of free software.  You can  use, 
% modify and/ or redistribute the software under the terms of the CeCILL
% license as circulated by CEA, CNRS and INRIA at the following URL
% "http://www.cecill.info". 
% 
% As a counterpart to the access to the source code and  rights to copy,
% modify and redistribute granted by the license, users are provided only
% with a limited warranty  and the software's author,  the holder of the
% economic rights,  and the successive licensors  have only  limited
% liability. 
% 
% In this respect, the user's attention is drawn to the risks associated
% with loading,  using,  modifying and/or developing or reproducing the
% software by the user in light of its specific status of free software,
% that may mean  that it is complicated to manipulate,  and  that  also
% therefore means  that it is reserved for developers  and  experienced
% professionals having in-depth computer knowledge. Users are therefore
% encouraged to load and test the software's suitability as regards their
% requirements in conditions enabling the security of their systems and/or 
% data to be ensured and,  more generally, to use and operate it in the 
% same conditions as regards security. 
% 
% The fact that you are presently reading this means that you have had
% knowledge of the CeCILL license and that you accept its terms.

function graph = grasp_watts_strogatz(N, K, beta)
    %% Initialization
    graph = grasp_struct;
    graph.A(N, N) = 0;
    nbRightNeighbors = floor(K / 2);
    
    %% Add neighbors
    for i = 1:N
        for j = (i + 1):(i + nbRightNeighbors)
            k = mod(j - 1, N) + 1;
            graph.A(i, k) = 1;
            graph.A(k, i) = 1;
        end
    end
    
    %% Rewiring
    for i = 1:N
        for j = (i + 1):N
            if graph.A(i, j) > 0 && rand(1) < beta
                k = randi([1 N]);
                while k == i || graph.A(i, k) > 0
                    k = randi([1 N]);
                end
                graph.A(i, j) = 0;
                graph.A(j, i) = 0;
                graph.A(i, k) = 1;
                graph.A(k, i) = 1;
            end
        end
    end
    
    %% Layout
    tmp = grasp_directed_cycle(N);
    graph.layout = tmp.layout;
end