package com.example.kilojoulecounter;

import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.ArrayList;


public class MainActivity extends AppCompatActivity {

    ListView listView;
    ArrayList<String> arrayList;
    ArrayAdapter arrayAdapter;
    ArrayList<Intent> entries;
    ArrayList<Integer> nkiList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //arrayList = new ArrayList<>();
        loadData();
        nkiList = new ArrayList<>();
        entries = new ArrayList<>();
        listView = findViewById(R.id.listView);
        arrayAdapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1, arrayList);
        listView.setAdapter(arrayAdapter);
        TextView avgCounter = findViewById(R.id.avgCounter);
        avgCounter.setText("The average Net Kilojoule Intake is " + averageCounter());
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Intent diary = entries.get(i);
                startActivity(diary);
            }
        });
    }



    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data){
        if (requestCode == 1 && resultCode == RESULT_OK){
            String date = data.getExtras().getString("Date");
            int counter = data.getExtras().getInt("NKJIC");
            //addToList(date + " " + counter);
            if (date != null){
                addToList("Date: " + date + "  ---  Net Kilojoule Intake: " + counter);
                entries.add(data);
                listView.setAdapter(arrayAdapter);
                TextView avgCounter = findViewById(R.id.avgCounter);
                nkiList.add(counter);
                avgCounter.setText("The average Net Kilojoule Intake is " + averageCounter());
                saveData();
            }
        }

    }


    public void calculate_nki(View v){
        Intent calc = new Intent(this, Calculator.class);
        startActivityForResult(calc, 1);
    }

    public void addToList(String entry){
        arrayList.add(entry);
    }

    private void saveData(){
        SharedPreferences sharedPreferences = getSharedPreferences("shared preferences", MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        Gson gson = new Gson();
        String json = gson.toJson(arrayList);
        editor.putString("task list", json);
        editor.apply();
    }

    private void loadData() {
        SharedPreferences sharedPreferences = getSharedPreferences("shared preferences", MODE_PRIVATE);
        Gson gson = new Gson();
        String json = sharedPreferences.getString("task list", null);
        Type type = new TypeToken<ArrayList<String>>() {}.getType();
        arrayList = gson.fromJson(json, type);

        if (arrayList == null) {
            arrayList = new ArrayList<>();
        }
    }

    private double averageCounter(){
        nkiList.size();
        int counterSum = 0;
        for (int i = 0; i < nkiList.size(); i++){
            counterSum = nkiList.get(i) + counterSum;
        }
        if (nkiList.size() != 0) {
            int avg = counterSum / nkiList.size();
            return avg;
        }
        return 0;
    }

}
