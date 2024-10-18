namespace Project_Final
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.panel1 = new System.Windows.Forms.Panel();
            this.label7 = new System.Windows.Forms.Label();
            this.tempDisplay = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.text_int0 = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.but_timer1 = new System.Windows.Forms.Button();
            this.listTimer1 = new System.Windows.Forms.ComboBox();
            this.label3 = new System.Windows.Forms.Label();
            this.but_connect = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.listBaud = new System.Windows.Forms.ComboBox();
            this.listPort = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.serialPort = new System.IO.Ports.SerialPort(this.components);
            this.panel2 = new System.Windows.Forms.Panel();
            this.led8 = new System.Windows.Forms.Button();
            this.img_led8 = new System.Windows.Forms.PictureBox();
            this.led7 = new System.Windows.Forms.Button();
            this.img_led7 = new System.Windows.Forms.PictureBox();
            this.led6 = new System.Windows.Forms.Button();
            this.img_led6 = new System.Windows.Forms.PictureBox();
            this.led5 = new System.Windows.Forms.Button();
            this.img_led5 = new System.Windows.Forms.PictureBox();
            this.led4 = new System.Windows.Forms.Button();
            this.img_led4 = new System.Windows.Forms.PictureBox();
            this.led3 = new System.Windows.Forms.Button();
            this.img_led3 = new System.Windows.Forms.PictureBox();
            this.led2 = new System.Windows.Forms.Button();
            this.img_led2 = new System.Windows.Forms.PictureBox();
            this.led1 = new System.Windows.Forms.Button();
            this.img_led1 = new System.Windows.Forms.PictureBox();
            this.label6 = new System.Windows.Forms.Label();
            this.zedGraphControl1 = new ZedGraph.ZedGraphControl();
            this.panel3 = new System.Windows.Forms.Panel();
            this.label8 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.label11 = new System.Windows.Forms.Label();
            this.label12 = new System.Windows.Forms.Label();
            this.label13 = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.img_led8)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.img_led7)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.img_led6)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.img_led5)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.img_led4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.img_led3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.img_led2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.img_led1)).BeginInit();
            this.panel3.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.LightSkyBlue;
            this.panel1.Controls.Add(this.panel3);
            this.panel1.Controls.Add(this.label7);
            this.panel1.Controls.Add(this.tempDisplay);
            this.panel1.Controls.Add(this.label5);
            this.panel1.Controls.Add(this.text_int0);
            this.panel1.Controls.Add(this.label4);
            this.panel1.Controls.Add(this.but_timer1);
            this.panel1.Controls.Add(this.listTimer1);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Controls.Add(this.but_connect);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.listBaud);
            this.panel1.Controls.Add(this.listPort);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Left;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(312, 450);
            this.panel1.TabIndex = 0;
            this.panel1.Paint += new System.Windows.Forms.PaintEventHandler(this.panel1_Paint);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Times New Roman", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(69, 298);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(29, 25);
            this.label7.TabIndex = 9;
            this.label7.Text = "C";
            // 
            // tempDisplay
            // 
            this.tempDisplay.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tempDisplay.Location = new System.Drawing.Point(23, 298);
            this.tempDisplay.Name = "tempDisplay";
            this.tempDisplay.Size = new System.Drawing.Size(40, 25);
            this.tempDisplay.TabIndex = 1;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(19, 272);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(149, 23);
            this.label5.TabIndex = 8;
            this.label5.Text = "Hiển thị nhiệt độ";
            // 
            // text_int0
            // 
            this.text_int0.BackColor = System.Drawing.SystemColors.Window;
            this.text_int0.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.text_int0.Location = new System.Drawing.Point(16, 227);
            this.text_int0.Name = "text_int0";
            this.text_int0.Size = new System.Drawing.Size(100, 25);
            this.text_int0.TabIndex = 1;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(19, 201);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(166, 23);
            this.label4.TabIndex = 7;
            this.label4.Text = "Sự kiện đếm được ";
            // 
            // but_timer1
            // 
            this.but_timer1.BackColor = System.Drawing.Color.MediumSeaGreen;
            this.but_timer1.Font = new System.Drawing.Font("Times New Roman", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.but_timer1.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.but_timer1.Location = new System.Drawing.Point(133, 149);
            this.but_timer1.Name = "but_timer1";
            this.but_timer1.Size = new System.Drawing.Size(136, 40);
            this.but_timer1.TabIndex = 6;
            this.but_timer1.Text = "OK";
            this.but_timer1.UseVisualStyleBackColor = false;
            this.but_timer1.Click += new System.EventHandler(this.but_timer1_Click);
            // 
            // listTimer1
            // 
            this.listTimer1.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.listTimer1.FormattingEnabled = true;
            this.listTimer1.Location = new System.Drawing.Point(16, 159);
            this.listTimer1.Name = "listTimer1";
            this.listTimer1.Size = new System.Drawing.Size(99, 25);
            this.listTimer1.TabIndex = 5;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(19, 117);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(228, 23);
            this.label3.TabIndex = 1;
            this.label3.Text = "Chế độ đèn chỉ thị \"RUN\"";
            // 
            // but_connect
            // 
            this.but_connect.BackColor = System.Drawing.Color.MediumSeaGreen;
            this.but_connect.Font = new System.Drawing.Font("Times New Roman", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.but_connect.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.but_connect.Location = new System.Drawing.Point(52, 65);
            this.but_connect.Name = "but_connect";
            this.but_connect.Size = new System.Drawing.Size(136, 40);
            this.but_connect.TabIndex = 1;
            this.but_connect.Text = "Connect";
            this.but_connect.UseVisualStyleBackColor = false;
            this.but_connect.Click += new System.EventHandler(this.but_connect_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(129, 9);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(88, 23);
            this.label2.TabIndex = 3;
            this.label2.Text = "Baudrate";
            // 
            // listBaud
            // 
            this.listBaud.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.listBaud.FormattingEnabled = true;
            this.listBaud.Location = new System.Drawing.Point(133, 34);
            this.listBaud.Name = "listBaud";
            this.listBaud.Size = new System.Drawing.Size(100, 25);
            this.listBaud.TabIndex = 2;
            // 
            // listPort
            // 
            this.listPort.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.listPort.FormattingEnabled = true;
            this.listPort.Location = new System.Drawing.Point(11, 34);
            this.listPort.Name = "listPort";
            this.listPort.Size = new System.Drawing.Size(99, 25);
            this.listPort.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(12, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(64, 23);
            this.label1.TabIndex = 1;
            this.label1.Text = "PORT";
            // 
            // serialPort
            // 
            this.serialPort.DataReceived += new System.IO.Ports.SerialDataReceivedEventHandler(this.serialPort_DataReceived);
            // 
            // panel2
            // 
            this.panel2.BackColor = System.Drawing.Color.Azure;
            this.panel2.Controls.Add(this.led8);
            this.panel2.Controls.Add(this.img_led8);
            this.panel2.Controls.Add(this.led7);
            this.panel2.Controls.Add(this.img_led7);
            this.panel2.Controls.Add(this.led6);
            this.panel2.Controls.Add(this.img_led6);
            this.panel2.Controls.Add(this.led5);
            this.panel2.Controls.Add(this.img_led5);
            this.panel2.Controls.Add(this.led4);
            this.panel2.Controls.Add(this.img_led4);
            this.panel2.Controls.Add(this.led3);
            this.panel2.Controls.Add(this.img_led3);
            this.panel2.Controls.Add(this.led2);
            this.panel2.Controls.Add(this.img_led2);
            this.panel2.Controls.Add(this.led1);
            this.panel2.Controls.Add(this.img_led1);
            this.panel2.Controls.Add(this.label6);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel2.Location = new System.Drawing.Point(312, 0);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(488, 140);
            this.panel2.TabIndex = 1;
            // 
            // led8
            // 
            this.led8.BackColor = System.Drawing.Color.MediumSeaGreen;
            this.led8.Font = new System.Drawing.Font("Times New Roman", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.led8.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.led8.Location = new System.Drawing.Point(433, 86);
            this.led8.Name = "led8";
            this.led8.Size = new System.Drawing.Size(55, 40);
            this.led8.TabIndex = 20;
            this.led8.Text = "ON";
            this.led8.UseVisualStyleBackColor = false;
            this.led8.Click += new System.EventHandler(this.led8_Click);
            // 
            // img_led8
            // 
            this.img_led8.Image = ((System.Drawing.Image)(resources.GetObject("img_led8.Image")));
            this.img_led8.Location = new System.Drawing.Point(433, 34);
            this.img_led8.Name = "img_led8";
            this.img_led8.Size = new System.Drawing.Size(51, 46);
            this.img_led8.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.img_led8.TabIndex = 19;
            this.img_led8.TabStop = false;
            // 
            // led7
            // 
            this.led7.BackColor = System.Drawing.Color.MediumSeaGreen;
            this.led7.Font = new System.Drawing.Font("Times New Roman", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.led7.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.led7.Location = new System.Drawing.Point(372, 86);
            this.led7.Name = "led7";
            this.led7.Size = new System.Drawing.Size(55, 40);
            this.led7.TabIndex = 18;
            this.led7.Text = "ON";
            this.led7.UseVisualStyleBackColor = false;
            this.led7.Click += new System.EventHandler(this.led7_Click);
            // 
            // img_led7
            // 
            this.img_led7.Image = ((System.Drawing.Image)(resources.GetObject("img_led7.Image")));
            this.img_led7.Location = new System.Drawing.Point(372, 34);
            this.img_led7.Name = "img_led7";
            this.img_led7.Size = new System.Drawing.Size(51, 46);
            this.img_led7.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.img_led7.TabIndex = 17;
            this.img_led7.TabStop = false;
            // 
            // led6
            // 
            this.led6.BackColor = System.Drawing.Color.MediumSeaGreen;
            this.led6.Font = new System.Drawing.Font("Times New Roman", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.led6.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.led6.Location = new System.Drawing.Point(311, 86);
            this.led6.Name = "led6";
            this.led6.Size = new System.Drawing.Size(55, 40);
            this.led6.TabIndex = 16;
            this.led6.Text = "ON";
            this.led6.UseVisualStyleBackColor = false;
            this.led6.Click += new System.EventHandler(this.led6_Click);
            // 
            // img_led6
            // 
            this.img_led6.Image = ((System.Drawing.Image)(resources.GetObject("img_led6.Image")));
            this.img_led6.Location = new System.Drawing.Point(311, 34);
            this.img_led6.Name = "img_led6";
            this.img_led6.Size = new System.Drawing.Size(51, 46);
            this.img_led6.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.img_led6.TabIndex = 15;
            this.img_led6.TabStop = false;
            // 
            // led5
            // 
            this.led5.BackColor = System.Drawing.Color.MediumSeaGreen;
            this.led5.Font = new System.Drawing.Font("Times New Roman", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.led5.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.led5.Location = new System.Drawing.Point(250, 86);
            this.led5.Name = "led5";
            this.led5.Size = new System.Drawing.Size(55, 40);
            this.led5.TabIndex = 14;
            this.led5.Text = "ON";
            this.led5.UseVisualStyleBackColor = false;
            this.led5.Click += new System.EventHandler(this.led5_Click);
            // 
            // img_led5
            // 
            this.img_led5.Image = ((System.Drawing.Image)(resources.GetObject("img_led5.Image")));
            this.img_led5.Location = new System.Drawing.Point(250, 34);
            this.img_led5.Name = "img_led5";
            this.img_led5.Size = new System.Drawing.Size(51, 46);
            this.img_led5.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.img_led5.TabIndex = 13;
            this.img_led5.TabStop = false;
            // 
            // led4
            // 
            this.led4.BackColor = System.Drawing.Color.MediumSeaGreen;
            this.led4.Font = new System.Drawing.Font("Times New Roman", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.led4.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.led4.Location = new System.Drawing.Point(193, 86);
            this.led4.Name = "led4";
            this.led4.Size = new System.Drawing.Size(55, 40);
            this.led4.TabIndex = 12;
            this.led4.Text = "ON";
            this.led4.UseVisualStyleBackColor = false;
            this.led4.Click += new System.EventHandler(this.led4_Click);
            // 
            // img_led4
            // 
            this.img_led4.Image = ((System.Drawing.Image)(resources.GetObject("img_led4.Image")));
            this.img_led4.Location = new System.Drawing.Point(193, 34);
            this.img_led4.Name = "img_led4";
            this.img_led4.Size = new System.Drawing.Size(51, 46);
            this.img_led4.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.img_led4.TabIndex = 11;
            this.img_led4.TabStop = false;
            // 
            // led3
            // 
            this.led3.BackColor = System.Drawing.Color.MediumSeaGreen;
            this.led3.Font = new System.Drawing.Font("Times New Roman", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.led3.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.led3.Location = new System.Drawing.Point(132, 86);
            this.led3.Name = "led3";
            this.led3.Size = new System.Drawing.Size(55, 40);
            this.led3.TabIndex = 10;
            this.led3.Text = "ON";
            this.led3.UseVisualStyleBackColor = false;
            this.led3.Click += new System.EventHandler(this.led3_Click);
            // 
            // img_led3
            // 
            this.img_led3.Image = ((System.Drawing.Image)(resources.GetObject("img_led3.Image")));
            this.img_led3.Location = new System.Drawing.Point(132, 34);
            this.img_led3.Name = "img_led3";
            this.img_led3.Size = new System.Drawing.Size(51, 46);
            this.img_led3.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.img_led3.TabIndex = 9;
            this.img_led3.TabStop = false;
            // 
            // led2
            // 
            this.led2.BackColor = System.Drawing.Color.MediumSeaGreen;
            this.led2.Font = new System.Drawing.Font("Times New Roman", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.led2.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.led2.Location = new System.Drawing.Point(71, 86);
            this.led2.Name = "led2";
            this.led2.Size = new System.Drawing.Size(55, 40);
            this.led2.TabIndex = 8;
            this.led2.Text = "ON";
            this.led2.UseVisualStyleBackColor = false;
            this.led2.Click += new System.EventHandler(this.led2_Click);
            // 
            // img_led2
            // 
            this.img_led2.Image = ((System.Drawing.Image)(resources.GetObject("img_led2.Image")));
            this.img_led2.Location = new System.Drawing.Point(71, 34);
            this.img_led2.Name = "img_led2";
            this.img_led2.Size = new System.Drawing.Size(51, 46);
            this.img_led2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.img_led2.TabIndex = 7;
            this.img_led2.TabStop = false;
            // 
            // led1
            // 
            this.led1.BackColor = System.Drawing.Color.MediumSeaGreen;
            this.led1.Font = new System.Drawing.Font("Times New Roman", 7.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.led1.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.led1.Location = new System.Drawing.Point(10, 86);
            this.led1.Name = "led1";
            this.led1.Size = new System.Drawing.Size(55, 40);
            this.led1.TabIndex = 6;
            this.led1.Text = "ON";
            this.led1.UseVisualStyleBackColor = false;
            this.led1.Click += new System.EventHandler(this.led1_Click);
            // 
            // img_led1
            // 
            this.img_led1.Image = ((System.Drawing.Image)(resources.GetObject("img_led1.Image")));
            this.img_led1.Location = new System.Drawing.Point(10, 34);
            this.img_led1.Name = "img_led1";
            this.img_led1.Size = new System.Drawing.Size(51, 46);
            this.img_led1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.img_led1.TabIndex = 5;
            this.img_led1.TabStop = false;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(1, 9);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(145, 23);
            this.label6.TabIndex = 4;
            this.label6.Text = "Điều khiển LED";
            // 
            // zedGraphControl1
            // 
            this.zedGraphControl1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.zedGraphControl1.Location = new System.Drawing.Point(312, 125);
            this.zedGraphControl1.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
            this.zedGraphControl1.Name = "zedGraphControl1";
            this.zedGraphControl1.ScrollGrace = 0D;
            this.zedGraphControl1.ScrollMaxX = 0D;
            this.zedGraphControl1.ScrollMaxY = 0D;
            this.zedGraphControl1.ScrollMaxY2 = 0D;
            this.zedGraphControl1.ScrollMinX = 0D;
            this.zedGraphControl1.ScrollMinY = 0D;
            this.zedGraphControl1.ScrollMinY2 = 0D;
            this.zedGraphControl1.Size = new System.Drawing.Size(488, 325);
            this.zedGraphControl1.TabIndex = 2;
            this.zedGraphControl1.UseExtendedPrintDialog = true;
            this.zedGraphControl1.Load += new System.EventHandler(this.zedGraphControl1_Load);
            // 
            // panel3
            // 
            this.panel3.BackColor = System.Drawing.Color.Azure;
            this.panel3.Controls.Add(this.label13);
            this.panel3.Controls.Add(this.label12);
            this.panel3.Controls.Add(this.label11);
            this.panel3.Controls.Add(this.label10);
            this.panel3.Controls.Add(this.label9);
            this.panel3.Controls.Add(this.label8);
            this.panel3.ForeColor = System.Drawing.SystemColors.ControlText;
            this.panel3.Location = new System.Drawing.Point(0, 326);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(312, 121);
            this.panel3.TabIndex = 3;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.ForeColor = System.Drawing.SystemColors.ControlText;
            this.label8.Location = new System.Drawing.Point(3, 11);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(73, 23);
            this.label8.TabIndex = 2;
            this.label8.Text = "Họ tên:";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.ForeColor = System.Drawing.SystemColors.ControlText;
            this.label9.Location = new System.Drawing.Point(70, 11);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(178, 22);
            this.label9.TabIndex = 3;
            this.label9.Text = "Nguyễn Hoàng Thắng";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label10.ForeColor = System.Drawing.SystemColors.ControlText;
            this.label10.Location = new System.Drawing.Point(3, 47);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(74, 23);
            this.label10.TabIndex = 4;
            this.label10.Text = "MSSV: ";
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label11.ForeColor = System.Drawing.SystemColors.ControlText;
            this.label11.Location = new System.Drawing.Point(70, 47);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(126, 22);
            this.label11.TabIndex = 5;
            this.label11.Text = "N21DCVT097";
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label12.ForeColor = System.Drawing.SystemColors.ControlText;
            this.label12.Location = new System.Drawing.Point(3, 82);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(56, 23);
            this.label12.TabIndex = 6;
            this.label12.Text = "Lớp: ";
            // 
            // label13
            // 
            this.label13.AutoSize = true;
            this.label13.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label13.ForeColor = System.Drawing.SystemColors.ControlText;
            this.label13.Location = new System.Drawing.Point(70, 83);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(137, 22);
            this.label13.TabIndex = 7;
            this.label13.Text = "D21CQVT01-N";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.zedGraphControl1);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.panel1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.img_led8)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.img_led7)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.img_led6)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.img_led5)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.img_led4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.img_led3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.img_led2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.img_led1)).EndInit();
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button but_connect;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox listBaud;
        private System.Windows.Forms.ComboBox listPort;
        private System.IO.Ports.SerialPort serialPort;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox listTimer1;
        private System.Windows.Forms.Button but_timer1;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox text_int0;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox tempDisplay;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Button led1;
        private System.Windows.Forms.PictureBox img_led1;
        private System.Windows.Forms.Button led8;
        private System.Windows.Forms.PictureBox img_led8;
        private System.Windows.Forms.Button led7;
        private System.Windows.Forms.PictureBox img_led7;
        private System.Windows.Forms.Button led6;
        private System.Windows.Forms.PictureBox img_led6;
        private System.Windows.Forms.Button led5;
        private System.Windows.Forms.PictureBox img_led5;
        private System.Windows.Forms.Button led4;
        private System.Windows.Forms.PictureBox img_led4;
        private System.Windows.Forms.Button led3;
        private System.Windows.Forms.PictureBox img_led3;
        private System.Windows.Forms.Button led2;
        private System.Windows.Forms.PictureBox img_led2;
        private ZedGraph.ZedGraphControl zedGraphControl1;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label13;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.Label label11;
    }
}

