package com.example.kilojoulecounter;

import android.app.Activity;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

public class Calculator extends AppCompatActivity {

    public int Lunch;
    public int Dinner;
    public int Sport;
    public int Jogging;
    public int food;
    public int exercise;
    public int nki;
    public String date;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_calculator);

        /*Intent edit = getIntent();
        Bundle bndl = edit.getExtras();
        int lnch = bndl.getInt("Lunch");
        int dnnr = bndl.getInt("Dinner");
        int sprt = bndl.getInt("Sport");
        int jggng = bndl.getInt("Jogging");
        String date = bndl.getString("Date");
        EditText lunch = findViewById(R.id.Lunch);
        EditText dinner = findViewById(R.id.Dinner);
        EditText sport = findViewById(R.id.Sport);
        EditText jogging = findViewById(R.id.Jogging);
        EditText Date = findViewById(R.id.Date);
        if (date != null){
            lunch.setText(lnch);
            dinner.setText(dnnr);
            sport.setText(sprt);
            jogging.setText(jggng);
            Date.setText(date);
            calculate();
        }*/
    }

    public void previous(View view){
        finish();
    }

    public void save(View vw){
        Intent diary = new Intent(getApplicationContext(), Diary.class);
        Bundle bundle = new Bundle();
        bundle.putInt("Lunch", Lunch);
        bundle.putInt("Dinner", Dinner);
        bundle.putInt("Sport", Sport);
        bundle.putInt("Jogging", Jogging);
        bundle.putInt("NKJIC", nki);
        bundle.putString("Date", date);
        diary.putExtras(bundle);
        setResult(RESULT_OK, diary);
        startActivity(diary);
        finish();
        /*Intent overview = new Intent(this, MainActivity.class);
        overview.putExtras(bundle);
        MainActivity ma = new MainActivity();
        ma.addToList(date + " " + nki);*/
    }

    public void calculations(View v){
        EditText lunch = findViewById(R.id.Lunch);
        EditText dinner = findViewById(R.id.Dinner);
        EditText sport = findViewById(R.id.Sport);
        EditText jogging = findViewById(R.id.Jogging);
        EditText Date = findViewById(R.id.Date);
        Lunch = Integer.parseInt(lunch.getText().toString());
        Dinner = Integer.parseInt(dinner.getText().toString());
        Sport = Integer.parseInt(sport.getText().toString());
        Jogging = Integer.parseInt(jogging.getText().toString());
        food = Lunch + Dinner;
        exercise = Sport + Jogging;
        nki = food - exercise;
        date = Date.getText().toString();
        TextView grossIntake = findViewById(R.id.grossIntake);
        TextView grossDepleted = findViewById(R.id.grossDepleted);
        TextView nkic = findViewById(R.id.NetKiloJoulesInTake);
        grossIntake.setText(String.valueOf(food));
        grossDepleted.setText(String.valueOf(exercise));
        nkic.setText(String.valueOf(nki));
    }

    public void calculate(){
        food = Lunch + Dinner;
        exercise = Sport + Jogging;
        nki = food - exercise;
        TextView grossIntake = findViewById(R.id.grossIntake);
        TextView grossDepleted = findViewById(R.id.grossDepleted);
        TextView nkic = findViewById(R.id.NetKiloJoulesInTake);
        grossIntake.setText(String.valueOf(food));
        grossDepleted.setText(String.valueOf(exercise));
        nkic.setText(String.valueOf(nki));
    }
}
