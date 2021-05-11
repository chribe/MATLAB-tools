function DisplayMultiMat(Mat)
   fig=uifigure('Name','DisplayMultiMat');
   ax=axes(fig);
   numberofslidersinLine=2;
   %determine dimensions
   S=size(Mat);
   %handle simple cases
   if length(S)==1
       plot(ax,Mat)
   elseif length(S)==2
       mesh(ax,Mat)
   else
       for hiSl=1:length(S)
           if hiSl==1
                sld(1) = uislider(fig,'Value',1,'Limits',[1,S(hiSl)+1],'ValueChangedFcn',@(event,sld)replot(ax,Mat));
           elseif (hiSl-1)/numberofslidersinLine==round((hiSl-1)/numberofslidersinLine)
               sld(hiSl)=uislider(fig,'Value',1,'Limits',[1,S(hiSl)+1],'Position',sld(hiSl-numberofslidersinLine).Position,'ValueChangedFcn',@(event,sld)replot(ax,Mat));
               sld(hiSl).Position(2)=.7*sld(hiSl).Position(2);
           else
               sld(hiSl)=uislider(fig,'Value',1,'Limits',[1,S(hiSl)+1],'Position',sld(hiSl-1).Position,'ValueChangedFcn',@(event,sld)replot(ax,Mat));
               sld(hiSl).Position(1)=1.1*(sld(hiSl).Position(1)+sld(hiSl).Position(3));
           end
       end
       numberofDP=0;
       txt='mesh(ax,squeeze(Mat(';
       for hiSl=1:length(S)
           if numberofDP<2
               txt=[txt ':,'];
               numberofDP=numberofDP+1;
           else
                txt=[txt num2str(round(sld(hiSl).Value)) ','];
           end
       end
       txt=[txt(1:end-1) ,')))'];
       eval(txt)
       end
       function replot(ax,Mat)
           numbofDP=0;
           view=ax.View;
           txt1='mesh(ax,squeeze(Mat(';
           for hiSl1=1:length(sld)
               if sld(hiSl1).Value==sld(hiSl1).Limits(2) & numbofDP<3
                   txt1=[txt1 ':,'];
                   numbofDP=numbofDP+1;
                   if numbofDP==1
                       xl=['Slider #' num2str(hiSl1)];
                   else
                       yl=['Slider #' num2str(hiSl1)];
                   end
               else
                    txt1=[txt1 num2str(round(sld(hiSl1).Value)) ','];
               end
           end
           txt1=[txt1(1:end-1) ,'))'')'];
           if numbofDP==1
           eval(strrep(txt1,'mesh','plot'))
           elseif numbofDP<3
               eval(txt1)
               ax.View=view;
               ax.XLabel.String=xl;
               ax.YLabel.String=yl;
           end
       end
   end
