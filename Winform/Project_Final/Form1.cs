using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO.Ports;
using System.Security.Cryptography.X509Certificates;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using Project_Final.Properties;
using ZedGraph;
using System.Drawing.Imaging;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Text.RegularExpressions;
namespace Project_Final
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        string[] baud = { "1200", "2400", "4800", "9600", "19200", "38400", "57600", "115200" };
        string[] timeHex = { "F0BD", "E17C", "D23A", "C2F8", "B3B5", "A473", "9531", "85EF", "76AC", "676A" };
        string[] time = { "0.5s", "1s", "1.5s", "2s", "2.5s", "3s", "3.5s", "4s", "4.5s", "5s" };
        private void panel1_Paint(object sender, PaintEventArgs e)
        {
          
        }
        private Dictionary<string, string> mapTimer1=new Dictionary<string, string>();
        private void Form1_Load(object sender, EventArgs e)
        {
            string[] listNamePort = SerialPort.GetPortNames();
            listPort.Items.AddRange(listNamePort);
            listBaud.Items.AddRange(baud);
            listTimer1.Items.AddRange(time);
            
            for(int i = 0; i < time.Length; i++)
            {
                mapTimer1.Add(time[i], timeHex[i]);
            }


            GraphPane myPanne = zedGraphControl1.GraphPane;
            myPanne.Title.Text = "Nhiệt Độ trên ATMEGA16";
            myPanne.YAxis.Title.Text = "Nhiệt độ";
            myPanne.XAxis.Title.Text = "Thời gian";

            RollingPointPairList list = new RollingPointPairList(60000);
            LineItem line = myPanne.AddCurve("nhiệt độ", list, Color.Red, SymbolType.Diamond);

            myPanne.XAxis.Scale.Min = 0;
            myPanne.XAxis.Scale.Max = 50;
            myPanne.XAxis.Scale.MinorStep = 1;
            myPanne.XAxis.Scale.MajorStep = 2;

            myPanne.YAxis.Scale.Min = 0;
            myPanne.YAxis.Scale.Max = 50;
            myPanne.YAxis.Scale.MinorStep = 1;
            myPanne.YAxis.Scale.MajorStep = 2;

            zedGraphControl1.AxisChange();
        }

        private void but_connect_Click(object sender, EventArgs e)
        {
            if (listPort.Text == "")
            {
                MessageBox.Show("Vui lòng chọn PORT!", "Thông báo");
            }
            if (listBaud.Text == "")
            {
                MessageBox.Show("Vui lòng chọn BAUD!", "Thông báo");
            }
            if (serialPort.IsOpen)
            {
                serialPort.Close();
                but_connect.Text = "Connect";
            }else
            {
                serialPort.PortName = listPort.Text;
                serialPort.BaudRate = int.Parse(listBaud.Text);
                serialPort.Open();
                but_connect.Text = "Disconnect";
            }
        }

        private void but_timer1_Click(object sender, EventArgs e)
        {

            if (listTimer1.Text == "")
            {
                MessageBox.Show("Vui lòng chọn thời gian định thời đèn chỉ thị!", "Thông báo");
            }if (serialPort.IsOpen)
            {
                string selectedTime=listTimer1.SelectedItem.ToString();
                string dataHex = mapTimer1[selectedTime];
                serialPort.WriteLine(dataHex);
            }
            else
            {
                MessageBox.Show("Vui lòng ấn \"Connect\"");
            }
        }
        bool dataTemp=false, receivedData=false;

        private void led1_Click(object sender, EventArgs e)
        {
            if (!serialPort.IsOpen)
            {
                MessageBox.Show("Vui lòng nhấn \"Connect\"!");
            }else if (led1.Text == "ON")
            {
                serialPort.Write("a");
                img_led1.Image = new Bitmap(Application.StartupPath+ "\\Resources\\Vexels-Office-Bulb.512.png");    
                led1.Text = "OFF";
            }
            else
            {
                led1.Text = "ON";
                serialPort.Write("a");
                img_led1.Image = new Bitmap(Application.StartupPath + "\\Resources\\Pixelkit-Swanky-Outlines-15-Light-Bulb.256.png");
            }

        }

        private void led2_Click(object sender, EventArgs e)
        {
            if (!serialPort.IsOpen)
            {
                MessageBox.Show("Vui lòng nhấn \"Connect\"!");
            }
            else if (led2.Text == "ON")
            {
                serialPort.Write("b");
                img_led2.Image = new Bitmap(Application.StartupPath + "\\Resources\\Vexels-Office-Bulb.512.png");
                led2.Text = "OFF";
            }
            else
            {
                led2.Text = "ON";
                img_led2.Image = new Bitmap(Application.StartupPath + "\\Resources\\Pixelkit-Swanky-Outlines-15-Light-Bulb.256.png");
                serialPort.Write("b");
            }
        }

        private void led3_Click(object sender, EventArgs e)
        {
            if (!serialPort.IsOpen)
            {
                MessageBox.Show("Vui lòng nhấn \"Connect\"!");
            }
            else if (led3.Text == "ON")
            {
                serialPort.Write("c");
                img_led3.Image = new Bitmap(Application.StartupPath + "\\Resources\\Vexels-Office-Bulb.512.png");
                led3.Text = "OFF";
            }
            else
            {
                led3.Text = "ON";
                img_led3.Image = new Bitmap(Application.StartupPath + "\\Resources\\Pixelkit-Swanky-Outlines-15-Light-Bulb.256.png");
                serialPort.Write("c");
            }
        }

        private void led4_Click(object sender, EventArgs e)
        {
            if (!serialPort.IsOpen)
            {
                MessageBox.Show("Vui lòng nhấn \"Connect\"!");
            }
            else if (led4.Text == "ON")
            {
                serialPort.Write("d");
                img_led4.Image = new Bitmap(Application.StartupPath + "\\Resources\\Vexels-Office-Bulb.512.png");
                led4.Text = "OFF";
            }
            else
            {
                led4.Text = "ON";
                img_led4.Image = new Bitmap(Application.StartupPath + "\\Resources\\Pixelkit-Swanky-Outlines-15-Light-Bulb.256.png");
                serialPort.Write("d");
            }
        }

        private void led5_Click(object sender, EventArgs e)
        {
            if (!serialPort.IsOpen)
            {
                MessageBox.Show("Vui lòng nhấn \"Connect\"!");
            }
            else if (led5.Text == "ON")
            {
                serialPort.Write("e");
                img_led5.Image = new Bitmap(Application.StartupPath + "\\Resources\\Vexels-Office-Bulb.512.png");
                led5.Text = "OFF";
            }
            else
            {
                led5.Text = "ON";
                img_led5.Image = new Bitmap(Application.StartupPath + "\\Resources\\Pixelkit-Swanky-Outlines-15-Light-Bulb.256.png");
                serialPort.Write("e");
            }
        }

        private void led6_Click(object sender, EventArgs e)
        {
            if (!serialPort.IsOpen)
            {
                MessageBox.Show("Vui lòng nhấn \"Connect\"!");
            }
            else if (led6.Text == "ON")
            {
                serialPort.Write("f");
                img_led6.Image = new Bitmap(Application.StartupPath + "\\Resources\\Vexels-Office-Bulb.512.png");
                led6.Text = "OFF";
            }
            else
            {
                led6.Text = "ON";
                serialPort.Write("f");
                img_led6.Image = new Bitmap(Application.StartupPath + "\\Resources\\Pixelkit-Swanky-Outlines-15-Light-Bulb.256.png");
            }
        }

        private void led7_Click(object sender, EventArgs e)
        {
            if (!serialPort.IsOpen)
            {
                MessageBox.Show("Vui lòng nhấn \"Connect\"!");
            }
            else if (led7.Text == "ON")
            {
                serialPort.Write("g");
                img_led7.Image = new Bitmap(Application.StartupPath + "\\Resources\\Vexels-Office-Bulb.512.png");
                led7.Text = "OFF";
            }
            else
            {
                led7.Text = "ON";
                serialPort.Write("g");
                img_led7.Image = new Bitmap(Application.StartupPath + "\\Resources\\Pixelkit-Swanky-Outlines-15-Light-Bulb.256.png");
            }
        }

        private void led8_Click(object sender, EventArgs e)
        {
            if (!serialPort.IsOpen)
            {
                MessageBox.Show("Vui lòng nhấn \"Connect\"!");
            }
            else if (led8.Text == "ON")
            {
                serialPort.Write("h");
                img_led8.Image = new Bitmap(Application.StartupPath + "\\Resources\\Vexels-Office-Bulb.512.png");
                led8.Text = "OFF";
            }
            else
            {
                led8.Text = "ON";
                serialPort.Write("h");
                img_led8.Image = new Bitmap(Application.StartupPath + "\\Resources\\Pixelkit-Swanky-Outlines-15-Light-Bulb.256.png");
            }
        }
        private void zedGraphControl1_Load(object sender, EventArgs e)
        {
            GraphPane myPanne = zedGraphControl1.GraphPane;
            myPanne.Title.Text = "Nhiệt Độ trên ATMEGA16";
            myPanne.Y2Axis.Title.Text = "Nhiệt độ";
            myPanne.XAxis.Title.Text = "Thời gian";

            RollingPointPairList list = new RollingPointPairList(60000);
            LineItem line = myPanne.AddCurve("nhiệt độ", list, Color.Red, SymbolType.Diamond);

            myPanne.XAxis.Scale.Min = 0;
            myPanne.XAxis.Scale.Max = 50;
            myPanne.XAxis.Scale.MinorStep = 1;
            myPanne.XAxis.Scale.MajorStep = 2;

            myPanne.YAxis.Scale.Min = 0;
            myPanne.YAxis.Scale.Max = 50;
            myPanne.YAxis.Scale.MinorStep = 1;
            myPanne.YAxis.Scale.MajorStep = 2;

            zedGraphControl1.AxisChange();
        }
        int sum = 0;
        public void drawMap(double line)
        {
            LineItem item = zedGraphControl1.GraphPane.CurveList[0] as LineItem;
            if (item == null)
            {
                return;
            }
            IPointListEdit list = item.Points as IPointListEdit;
            if (list == null)
            {
                return;
            }

            list.Add(sum, line);
            zedGraphControl1.AxisChange();
            zedGraphControl1.Invalidate();
            sum += 2;
            //if (zedGraphControl1.GraphPane.CurveList.Count > 0)
            //{
            //    LineItem item = zedGraphControl1.GraphPane.CurveList[0] as LineItem;
            //    if (item != null)
            //    {
            //        IPointListEdit list = item.Points as IPointListEdit;
            //        if (list != null)
            //        {
            //            list.Add(sum, line);
            //            zedGraphControl1.AxisChange();
            //            zedGraphControl1.Invalidate();
            //            sum += 2;
            //        }
            //    }
            //}
        }

        string dataReceive;
        string data = "";
        string regex = "";
        private void serialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            data += serialPort.ReadExisting();
            ////regex = "[^0-9]";
            //string result = Regex.Replace(data, regex, "");
            // True
            if (data.Contains("$"))
           {
                int index = data.IndexOf("$");
                string displayData = data.Substring(0, index);

                if (double.TryParse(displayData, out double convertedData))
                {
                    Invoke((MethodInvoker)(() =>
                    {
                        tempDisplay.Text = displayData;
                        tempDisplay.SelectionStart = tempDisplay.TextLength;
                        tempDisplay.ScrollToCaret();
                    }));
                    Invoke((MethodInvoker)(() => drawMap(convertedData)));
                }
                data = data.Substring(index + 1);
            }
            else if(data.Contains("#"))
            {
                int index1 = data.IndexOf("#");
                string displayData1 = data.Substring(0, index1);
                    Invoke((MethodInvoker)(() =>
                    {
                        text_int0.Text = displayData1;
                        text_int0.SelectionStart = text_int0.TextLength;
                        text_int0.ScrollToCaret();
                    }));
                }
        }
      
    }
}
