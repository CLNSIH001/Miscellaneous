package com.example.kilojoulecounter;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class Diary extends AppCompatActivity {
    private Intent calc;
    private Bundle bndl;
    int nkjic;
    String date;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_diary);

        TextView lnch = findViewById(R.id.lnch);
        TextView dnnr = findViewById(R.id.dnnr);
        TextView sprt = findViewById(R.id.sprt);
        TextView jog = findViewById(R.id.jog);
        calc = getIntent();
        bndl = calc.getExtras();
        int lunch = bndl.getInt("Lunch");
        int dinner = bndl.getInt("Dinner");
        int sport = bndl.getInt("Sport");
        int jogging = bndl.getInt("Jogging");
        lnch.setText(""+lunch);
        dnnr.setText(""+dinner);
        sprt.setText(""+sport);
        jog.setText(""+jogging);
        TextView NkJiC = findViewById(R.id.N_Kj_I_C);
        nkjic = bndl.getInt("NKJIC");
        NkJiC.setText("The Net Kilojoule Intake is "+ nkjic);
        TextView dt = findViewById(R.id.dt);
        date = bndl.getString("Date");
        dt.setText(date);
    }


    public void overview(View view){
        finish();
    }

    public void calculate_nki(View v){
        Intent edit = new Intent(this, Calculator.class);
        edit.putExtras(bndl);
        startActivityForResult(edit, 2);
        finish();
    }

}
