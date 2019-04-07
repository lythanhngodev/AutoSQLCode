<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="AuToSQLCode.Index" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <style>
        ::-webkit-scrollbar { width: 10px; } ::-webkit-scrollbar-track { background: #f1f1f1; } ::-webkit-scrollbar-thumb { background: #888; } ::-webkit-scrollbar-thumb:hover { background: #555; }
        select {
            width: 300px;
        }

        .khungcheckbox {
            margin: 3px;
            float: left;
            /*border: 1px solid #d2d2d2;*/
            display: inline-table;
            height: 30px;
            padding: 0px 5px;
        }

        #cottrongbang {
            width: 100%;
            float: left;
            border-left: 2px solid #d2d2d2;
            margin: 0;
            padding: 0;
            max-height: 440px;
            min-width: 200px;
            overflow: auto;
        }

        #cottrongbang li {
            list-style-type: none;
            display: inline-table;
            width: 100%;
        }
        .padding-none{
            padding: 0;
        }
    </style>
    <div class="container-fluid">
        <br />
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-12">
                        <b>Có thể cấu hình chuỗi kết nối trong file web.config</b>
                    </div>
                    <div class="col-md-10">
                        <input type="text" id="chuoiketnoi" class="form-control" style="width: 100%;" value="<%=(String.IsNullOrEmpty(System.Configuration.ConfigurationManager.ConnectionStrings["chuoiKetNoi"].ConnectionString)) ? "" : System.Configuration.ConfigurationManager.ConnectionStrings["chuoiKetNoi"].ConnectionString %>" placeholder="Data Source={Ten_May}\SQLEXPRESS;Initial Catalog=master;User ID={Ten_dang_nhap};Password={Mật_khẩu}" /><br />
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-primary" onclick="ketnoi();return false;">Kết nối CSDL</button>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <label>
                    <b>Chọn CSDL</b>&ensp;
                </label>
                <select id="selCSDL" class="form-control" style="width:100%">
                    <option value="">--Chọn CSDL--</option>
                </select>
            </div>
            <div class="col-md-6">
                <label>
                    <b>Chọn bảng</b>&ensp;
                </label>
                <select id="selBang" class="form-control" style="width:100%">
                    <option value="">--Chọn bảng--</option>
                </select>
            </div>
            <div class="col-md-12">
                <hr />
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 col-sm-5 padding-none">
                <div class="col-md-12">
                        <input type="checkbox" checked="checked" name="chontatca">&ensp;<b>Cột dữ liệu</b>
                </div>
                <div class="col-md-12">
                    <hr />
                </div>
                <div class="col-md-12">
                    <ul id="cottrongbang">
                    </ul>
                </div>
            </div>
            <div class="col-md-9 col-sm-7 padding-none">
                <div class="col-md-12">
                    <b>Chức năng</b>
                </div>
                <div class="col-md-12">
                     <hr />
                    <button class="btn btn-primary btn-sm" style="width: 100px" onclick="them();return false;">Thêm</button>&ensp;
                    <button class="btn btn-primary btn-sm" style="width: 100px" onclick="sua();return false;">Sửa</button>&ensp;
                    <button class="btn btn-primary btn-sm" style="width: 100px" onclick="xoa();return false;">Xóa</button>
                    <hr />
                </div>
                <div class="col-md-12" id="khungketqua">
                    <label><b>Chuỗi SQL</b></label>
                    <textarea id="ketqua" class="form-control" rows="8"></textarea>
                    <br />
                    <label><b>Parameters 1</b></label>
                    <textarea id="par" class="form-control" rows="8"></textarea>
                    <br />
                    <label><b>Parameters 2</b></label>
                    <textarea id="SqlParameter" class="form-control" rows="8"></textarea>
                    <br />
                    <label><b>Parameters 3</b></label>
                    <textarea id="txtparam" class="form-control" rows="8"></textarea>
                    <br />
                </div>
                <br />
            </div>
        </div>
    </div>
    <%--SqlParameter--%>
    <script>
        getAjax = (duongDanAjax, duLieuGui) => { var result = null; $.ajax({ type: "POST", url: duongDanAjax, data: JSON.stringify(duLieuGui), contentType: "application/json; charset=utf-8", dataType: "json", async: false, success: function (response) { result = response.d; }, error: function (response) { } }); if (result === null) return null; return JSON.parse(result.toString()); }
        $(()=>{
            $('select').select2(
                {
                    width : '100%'
                }
            );

            $(document).on('change', '#selCSDL', function () {
                try {
                    $('#selBang').find('option:eq(0)').prop('selected', true).change();
                    $('#selBang').find('option').not('option:eq(0)').remove();
                    var r = getAjax('Index.aspx/LayBangTuCSDL', { csdl: $(this).val(), kn: $('#chuoiketnoi').val() });
                    $.each(r, function () {
                        $('#selBang').append($('<option></option>').val(this['name']).html(this['name']));
                    });
                } catch (e) {
                    return false;
                }
            });
            $(document).on('change', '#selBang', function () {
                try {
                    $('#cottrongbang').find('li').remove();
                    var r = getAjax('Index.aspx/LayCotTuBang', { csdl: [$('#selCSDL').val(), $('#selBang').val()], kn: $('#chuoiketnoi').val() });
                    $.each(r, function () {
                        $('#cottrongbang').append(`<li><div class='khungcheckbox'><label><input type='checkbox' name='${this['TenCot']} ${this['Kieu']}' kieuthuan='${this['KieuThuan']}' checked='checked'>&ensp;${this['TenCot']} ${this['Kieu']}</label></div></li>`);
                    });
                    $('input[type=checkbox][name=chontatca]').prop('checked', true);
                } catch (e) {
                    return false;
                }
            });
        });
        $('input[type=checkbox][name=chontatca]').click(function(){
            ($('input[type=checkbox][name=chontatca]').prop('checked')) ? $('input[type=checkbox]').prop('checked', !0) : $('input[type=checkbox]').prop('checked', !1);
        });
        $(document).on('click', '#selCSDL,#selBang', ()=>{
            $('#cottrongbang').empty();
            $('#khungketqua').find('input,textarea').val(null);
        });
        ketnoi=()=>{
            var r = getAjax('Index.aspx/LayCSDL', { csdl: $('#chuoiketnoi').val() });
            $.each(r, function () {
                $('#selCSDL').append($('<option></option>').val(this['name']).html(this['name']));
            });
            if (jQuery.isEmptyObject(r)) {
                $('.container').find('select option:eq(0)').prop('selected', !0).change();
                $('.container').find('select option').not('option:eq(0)').remove();
            }
        }
        mau = () => {
            var array = new Array(), array_update = new Array(), array_del = new Array(), array_proc_par = new Array(), array_SqlParameter = new Array();
            $('input[type=checkbox]').not('input[type=checkbox][name=chontatca]').each(function () {
                $(this).is(':checked') && (
                    array.push($(this).attr('name').split(' ')[0]),
                    array_del.push($(this).attr('name').split(' ')[0]),
                    array_update.push($(this).attr('name').split(' ')[0] + " = @" + $(this).attr('name').split(' ')[1]),
                    array_proc_par.push(['@' + $(this).attr('name').split(' ')[0] + ' ' + $(this).attr('name').split(' ')[1]]),
                    array_SqlParameter.push([$(this).attr('name').split(' ')[0], $(this).attr('kieuthuan')])
                )
            });
            console.log(array_proc_par);
            var stringjoin = array.join(", "), string_join_param = "\t\t@" + array.join(",\n\t\t@"), stringjoin_update = '\t' + array_update.join(",\n\t");
            var string_proc_par = array_proc_par.join(",\n");
            array.length = 0;
            array.push(stringjoin); // 0
            array.push(string_join_param); // 1
            array.push(stringjoin_update); // 2
            (jQuery.isEmptyObject(array_del)) ? array.push(null) : array.push(array_del[0]); // 3
            array.push(string_proc_par); // 4
            array.push(array_SqlParameter); // 5
            return array;
        }
        Param=(obj)=>{
            var sql = "SqlCommand sqlCmd = new SqlCommand(strSQL, sqlConn);\n";
            $.each(obj, function (i, v) {
                sql += `sqlCmd.Parameters.AddWithValue(\"@${v}\", _arrayT[${i}].ToString());\n`;
            });
            $('#txtparam').val(sql);
        }
        SqlParameter = (obj)=>{
            var sql = "SqlParameter[] para = {\n";
            $.each(obj, function (i, v) {
                switch (v[1]) {
                    case 'uniqueidentifier':
                        sql += `\tnew SqlParameter(\"@${v[0]}\", (_arrayT[${i}].ToString().Trim().Length==0) ? default(Guid) : Guid.Parse(_arrayT[${i}].ToString())),\n`;
                        break;
                    case 'text':
                        sql += `\tnew SqlParameter(\"@${v[0]}\", _arrayT[${i}].ToString()),\n`;
                        break;
                    case 'nvarchar':
                        sql += `\tnew SqlParameter(\"@${v[0]}\", _arrayT[${i}].ToString()),\n`;
                        break;
                    case 'varchar':
                        sql += `\tnew SqlParameter(\"@${v[0]}\", _arrayT[${i}].ToString()),\n`;
                        break;
                    case 'char':
                        sql += `\tnew SqlParameter(\"@${v[0]}\", _arrayT[${i}].ToString()),\n`;
                        break;
                    case 'datetime':
                        sql += `\tnew SqlParameter(\"@${v[0]}\", (string.IsNullOrEmpty(_arrayT[${i}].ToString())) ? null : _arrayT[${i}].ToString()),\n`;
                        break;
                    case 'smalldatetime':
                        sql += `\tnew SqlParameter(\"@${v[0]}\", (string.IsNullOrEmpty(_arrayT[${i}].ToString())) ? null : _arrayT[${i}].ToString()),\n`;
                        break;
                    case 'decimal':
                        sql += `\tnew SqlParameter(\"@${v[0]}\", (DungChung.IsNumeric(DungChung.dinhDangSoSQL(_arrayT[${i}].ToString()))) ? DungChung.dinhDangSoSQL(_arrayT[${i}].ToString()) : "0"),\n`;
                        break;
                    case 'float':
                        sql += `\tnew SqlParameter(\"@${v[0]}\", (DungChung.IsNumeric(DungChung.dinhDangSoSQL(_arrayT[${i}].ToString()))) ? DungChung.dinhDangSoSQL(_arrayT[${i}].ToString()) : "0"),\n`;
                        break;
                    case 'bigint':
                        sql += `\tnew SqlParameter(\"@${v[0]}\", (DungChung.IsNumeric(DungChung.dinhDangSoSQL(_arrayT[${i}].ToString()))) ? DungChung.dinhDangSoSQL(_arrayT[${i}].ToString()) : "0"),\n`;
                        break;
                    case 'int':
                        sql += `\tnew SqlParameter(\"@${v[0]}\", (DungChung.IsNumeric(DungChung.dinhDangSoSQL(_arrayT[${i}].ToString()))) ? DungChung.dinhDangSoSQL(_arrayT[${i}].ToString()) : "0"),\n`;
                        break;
                    case 'money':
                        sql += `\tnew SqlParameter(\"@${v[0]}\", (DungChung.IsNumeric(DungChung.dinhDangSoSQL(_arrayT[${i}].ToString()))) ? DungChung.dinhDangSoSQL(_arrayT[${i}].ToString()) : "0"),\n`;
                        break;
                    case 'numeric':
                        sql += `\tnew SqlParameter(\"@${v[0]}\", (DungChung.IsNumeric(DungChung.dinhDangSoSQL(_arrayT[${i}].ToString()))) ? DungChung.dinhDangSoSQL(_arrayT[${i}].ToString()) : "0"),\n`;
                        break;
                    case 'bit':
                        sql += `\tnew SqlParameter(\"@${v[0]}\", Convert.ToBoolean(_arrayT[${i}].ToString())),\n`;
                        break;
                    default:
                        sql += `\tnew SqlParameter(\"@${v[0]}\", _arrayT[${i}].ToString()),\n`;
                        break;
                }
            });
            sql = sql.substring(0, sql.lastIndexOf(',')) + sql.substring(sql.lastIndexOf(',') + 1, sql.length);
            sql += '};';
            $('#SqlParameter').val(sql);
        }
        them = () => {
            $('#khungketqua').find('input,textarea').val(null);
            try {
                var obj = mau();
                $('#ketqua').val(`INSERT INTO \n\t${$('#selBang').val()} (${obj[0]}) \nVALUES \n\t(\n${obj[1]}\n\t)`);
                $('#par').val(`${obj[4]}`);
                Param((obj[0].split(", ")));
                SqlParameter(obj[5]);
            } catch (e) {

            }
        }
        sua = () => {
            $('#khungketqua').find('input,textarea').val(null);
            var obj = mau();
            var where = null;
            try {
                where = obj[0].split(", ")[0];
                $('#ketqua').val(`UPDATE ${$('#selBang').val()}\nSET\n  ${obj[2]}\nWHERE ${where} = @${where}`);
                $('#par').val(`${obj[4]}`);
                Param((obj[0].split(", ")));
                SqlParameter(obj[5]);
            } catch (e) {

            }
        }
        xoa = () => {
            $('#khungketqua').find('input,textarea').val(null);
            try {
                var obj = mau();
                $('#ketqua').val(`DELETE FROM ${$('#selBang').val()} WHERE ${obj[3]} = @${obj[3]}`);
                Param([(obj[0].split(", "))[0]]);
                $('#par').val(`${obj[4].split(",")[0]}`);
                SqlParameter([obj[5][0]]);
            } catch (e) {

            }
        }
    </script>
</asp:Content>