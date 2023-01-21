

-- hook.Add("OnPlayerChat", "Better_Inventory", function(ply, text, isTeamChat, isDead)
--     if string.sub(text, 1, 5) ~= "!binv" then return end

--     local W, H = ScrW(), ScrH()
--     local w, h = W / 2, H / 2
--     local frame = vgui.Create("AtlasUI.Frame")

--     frame:SetSize(w, h)
--     frame:Center()
--     frame:MakePopup()
--     frame:SetTitle("Better Inventory")

--     local WeaponList = vgui.Create( "DListView", frame )
--     -- WeaponList:SetPos(  )
--     WeaponList:SetSize(w * 0.45, h * 0.45)
--     WeaponList:Dock(LEFT)
--     WeaponList:DockMargin( w * 0.025, h * 0.05, w * 0.025, h * 0.05 )

--     WeaponList:SetMultiSelect( false )
--     WeaponList:AddColumn( "Weapon Name" )

--     for _, wep in ipairs( ply:GetWeapons() ) do
--         if wep.ClassName == "" or ! wep.ClassName then continue end
--         WeaponList:AddLine( wep.ClassName )
--     end

--     local userSelectedClassName = nil
--     WeaponList.OnRowSelected = function( panel, rowIndex, row )
--         local userSelectedClassName = row:GetValue( 1 )
--         local tbl = weapons.GetStored( userSelectedClassName )
--         if ! istable( tbl ) then return end
--         -- is the int an actual int? or throw an error msg
--         -- https://wiki.facepunch.com/gmod/DTextEntry:CheckNumeric
--         tbl.Slot = 4
--         tbl.SlotPos = 1
--     end



-- --  Slot
-- --     local SlotEntry = vgui.Create( "AtlasUI.TextEntry", frame )
-- --         SlotEntry:SetSize(w * 0.45, h * 0.45)
-- --         SlotEntry:Dock( TOP )
-- --         SlotEntry:DockMargin( w * 0.025, h * 0.05, w * 0.025, h * 0.05 )

-- --        SlotPos
-- --        local PosEntry = vgui.Create( "AtlasUI.TextEntry", frame )
-- --        PosEntry:SetSize(w * 0.005, h * 0.10)
-- --        PosEntry:Dock( TOP )
-- --        PosEntry:DockMargin( w * 0.125, h * 0.15, w * 0.125, h * 0.15 )   

-- -- local ApplyButton = vgui.Create( "DButton", frame )
-- --     ApplyButton.DoClick = function()
-- --         print( userSelectedClassName )
-- --         local tbl = weapons.GetStored( userSelectedClassName )
-- --         if ! istable( tbl ) then return end
-- --         -- is the int an actual int? or throw an error msg
-- --         -- https://wiki.facepunch.com/gmod/DTextEntry:CheckNumeric
-- --         tbl.Slot = int(dtextentry.GetValue())
-- --         tbl.SlotPos = 1
-- --     end
-- end)




print("HELLO I AM LOADED")

hook.Add("OnPlayerChat", "hellomynameiswhat", function(ply, text, _, _)

    if text != "!hello" then return end
    print("thanks for saying hello")


    local weps = ply:GetWeapons() or {}
    local W, H = ScrW(), ScrH()
    local w, h = W / 2, H / 2

    local mainPanel = vgui.Create( "DFrame" )
    mainPanel:SetSize( w, h )
    mainPanel:Center()
    mainPanel:MakePopup()

    local dlabelinfo1 = vgui.Create( "DLabel", mainPanel )
    dlabelinfo1:SetText("Info 1")
    dlabelinfo1:Dock(BOTTOM)

    local dlabelinfo2 = vgui.Create( "DLabel", mainPanel )
    dlabelinfo2:SetText("Info 2")
    dlabelinfo2:Dock(BOTTOM)

    local dlabelinfo3 = vgui.Create( "DLabel", mainPanel )
    dlabelinfo3:SetText("Info 3")
    dlabelinfo3:Dock(BOTTOM)

    local slots = {}
    local wepslots = {}

    for i = 1, 6 do
        local slotframes = vgui.Create("DListLayout", mainPanel)
        slotframes:SetSize(w / 8, h / 2)

        slotframes:SetPos( w / 28 * i + (w / 8 * (i-1)) , h / 15 )
        --Draw a background so we can see what it's doing
        slotframes:SetPaintBackground(true)
        slotframes:SetBackgroundColor(Color(2, 92, 92))
        slotframes:MakeDroppable( "unique_name" .. i ) -- Allows us to rearrange children
        slotframes:SetSelectable(true)

        table.insert(slots, slotframes)
        local slotname = vgui.Create("DLabel")
        slotname:SetName("slotnamelabel")
        slotname:SetText(" Slot " .. i)
        slotname:SetDisabled(true)
        slotname:SetPaintBackgroundEnabled(true)
            function slotname:PerformLayout()
                self:SetBGColor(Color(151, 21, 249))
            end
            slotframes:Add(slotname)



        local tempslot = {}
        for _, wep in ipairs( weps ) do
            -- if wep.ClassName == "" or ! wep.ClassName then continue end
            if wep.Slot != i - 1 then continue end
            table.insert(tempslot, wep)
        end

        table.sort(tempslot, function(a, b) return a.SlotPos < b.SlotPos end)

        for _, curwep in ipairs(tempslot) do
            local lbl = vgui.Create("DLabel")
            lbl:SetText(" Label " .. curwep.ClassName)
            lbl:SetName(curwep.ClassName )
            function lbl:DoClick() -- Defines what should happen when the label is clicked
                dlabelinfo1:SetText(" Label " .. curwep.ClassName .. " from Slot " .. i .. " was pressed ")
            end

            function lbl:OnMouseReleased( mousecode )

                self:MouseCapture( false )

                if ( self:GetDisabled() ) then return end
                if ( !self.Depressed && dragndrop.m_DraggingMain != self ) then return end

                if ( self.Depressed ) then
                    self.Depressed = nil
                    self:OnReleased()
                    self:InvalidateLayout( true )
                end

                --
                -- If we were being dragged then don't do the default behaviour!
                --
                if ( self:DragMouseRelease( mousecode ) ) then
                    -- if mousecode 
                    dlabelinfo2:SetText(" Label " .. curwep.ClassName .. " from Slot " .. i .. " was pressed ")
                    -- self:Remove()
                    cc , dd = mainPanel:CursorPos()
                    dlabelinfo3:SetText("Helloooo pls work" .. cc .. " " .. dd)
                    local bb = (mainPanel:GetChildrenInRect( cc, dd, w / 56, h / 30))
                    print(bb)
                    print(#bb)
                    PrintTable(bb)
                    bb[1]:Add(self)
                    return
                end

                if ( self:IsSelectable() && mousecode == MOUSE_LEFT ) then

                    local canvas = self:GetSelectionCanvas()
                    if ( canvas ) then
                        canvas:UnselectAll()
                    end

                end

                if ( !self.Hovered ) then return end

                --
                -- For the purposes of these callbacks we want to
                -- keep depressed true. This helps us out in controls
                -- like the checkbox in the properties dialog. Because
                -- the properties dialog will only manually change the value
                -- if IsEditing() is true - and the only way to work out if
                -- a label/button based control is editing is when it's depressed.
                --
                self.Depressed = true

                if ( mousecode == MOUSE_RIGHT ) then
                    self:DoRightClick()
                end

                if ( mousecode == MOUSE_LEFT ) then
                    self:DoClickInternal()
                    self:DoClick()
                end

                if ( mousecode == MOUSE_MIDDLE ) then
                    self:DoMiddleClick()
                end

                self.Depressed = nil

            end
            -- function lbl:DoClick() -- Defines what should happen when the label is clicked
            --     dlabelinfo2:SetText(" Label " .. ii .. " from Slot " .. i .. " was pressed ")
            -- end
            lbl = slotframes:Add( lbl )
            -- lbl.Think = function( s ) s:SetText( "ID: " .. curwep.ClassName .. " ZPOS: " .. s:GetZPos() ) end
            lbl.Think = function( s ) s:SetText( "ID: " .. curwep.ClassName .. " SlotPos " .. curwep.SlotPos ) end
            a = lbl
        end
    end



    local applybutton = vgui.Create( "DButton", mainPanel )
    applybutton:SetSize(w / 8, h / 8)

    applybutton:SetPos( w - (w / 28 + w / 8), h - (h / 15 + h / 8) )

    function applybutton:DoClick()
        for slotnum, singleslot in ipairs(slots) do
            chat.AddText(tostring(slotnum))
            for _, v in ipairs( singleslot:GetChildren() ) do
                local wepname = v:GetName()
                if wepname  == "slotnamelabel" then continue end
             -- chat.AddText(v:GetClassName())
                local tbl = weapons.GetStored( wepname )
                if ! istable( tbl ) then continue end
                tbl.Slot = slotnum - 1
                a,b = singleslot:GetChildPosition(v)
                tbl.SlotPos = (b / v:GetTall())
            end
        end

        chat.AddText("Applied!")
    end




    -- local userSelectedClassName = nil
    -- WeaponList.OnRowSelected = function( panel, rowIndex, row )
    --     local userSelectedClassName = row:GetValue( 1 )
    --     local tbl = weapons.GetStored( userSelectedClassName )
    --     if ! istable( tbl ) then return end
    --     -- is the int an actual int? or throw an error msg
    --     -- https://wiki.facepunch.com/gmod/DTextEntry:CheckNumeric
    --     tbl.Slot = 4
    --     tbl.SlotPos = 1
    -- end


    -- slotframes:Find("MyNameIs1"):Remove()

    -- local layout2 = vgui.Create("DListLayout", mainPanel)
    -- layout2:SetSize(w/10, h/2)
    -- layout2:Dock(LEFT)
    -- --Draw a background so we can see what it's doing
    -- layout2:SetPaintBackground(true)
    -- layout2:SetBackgroundColor(Color(0, 100, 100))
    -- layout2:MakeDroppable( "unique_name2" ) -- Allows us to rearrange children

    -- for i = 1, 7 do
    --     layout2:Add( Label( " Label " .. i ) )
    -- end




end)